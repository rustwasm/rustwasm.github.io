---
layout: post
title: "Multithreading Rust and Wasm"
author: "Alex Crichton"
---

When WebAssembly was first shipped it was an [MVP] which, while minimal, has
spawned a huge number of exciting projects which work today across all major
browsers. Rust has capitalized on the wasm MVP's success as well with tools
like [`wasm-bindgen`] and [`wasm-pack`] by making the MVP feel less minimal.
WebAssembly is [yet more ambitious][post-mvp], though! Since inception it's
always been intended to extend the [WebAssembly specification][spec] with new
features and functionality.

One of the features I'm particularly excited about coming down the pike for
WebAssembly is the [threads] proposal. The threading proposal was unfortunately
halted in its tracks when the [Spectre and Meltdown][vuln] vulnerabilities were
first announced, but it's starting to pick up steam again! Browsers will start
shipping [`SharedArrayBuffer`] in the near future, and threads for wasm won't be
far behind.

Features like threads for wasm can have a huge impact on Rust and how it's used
on the web, and we want to be sure that Rust is ready and well suited for wasm
threads as soon as they're available! I've recently started to try to get more
involved in the [WebAssembly Community Group][wacg] and this seemed like the
perfect opportunity to test out support for Rust while also hopefully providing
feedback for the proposal itself if necessary!

If you're itching for a happy ending you can [jump ahead to the end][end] where
(spoilers) there's a demo showing off Rust, WebAssembly, and threads all in the
browser.

> **Note**: As a note to future readers, this post describes and works with many
> features which, at the time of its writing, were unstable. Not everything here
> may be accurate in the distant future and examples may no longer work. We'll
> try to keep things updated but if you're reading this far from when it was
> written take it with a grain of salt!

### The WebAssembly threads proposal

While one might naively expect that the idea of "WebAssembly threads" is
something like "add pthreads" or "add `std::thread`" to wasm, the current
proposal for threads in WebAssembly is actually quite different! Instead of
providing a full library experience the threads proposal is instead specifying
the fundamental building blocks upon which you can build a threading library.

#### Atomic Instructions

The first aspect of the threads proposal that you might notice is the addition
of [atomic instructions][atomics]. In Rust parlance this means that
[`AtomicUsize`] and friends will actually compile to atomic operations, whereas
today they're [simply lowered to single-threaded equivalents][wasm-singlethread]
(as there's no threads!). While essential, these aren't too too thrilling just
yet until you hit [`wait` and `notify`][wait-and-notify].

Atomic modifications allow us to perform some level of synchronization, but
full synchronization often requires actual blocking of a thread until another is
finished. This is where the `i32.atomic.wait` and `atomic.notify` instructions
come into play. First we can block a thread (atomically) using
[`i32.atomic.wait`], and then another thread can execute [`atomic.notify`] to wake
up a thread blocked on the same address. I believe this is similar to [futexes]
on Linux, although I've never used them myself!

With just this one addition we can now start to see how primitives can be
formed, and sure enough the proposal has an [example mutex
implementation][mutex-example] which is also how [the Rust `Mutex` type is
implemented][rust-mutex] as well.

Ok that's great and all, but how do we spawn more than one thread?

#### Parallelism through Web Workers

One of WebAssembly's greatest strengths is that it *extends* the web platform
instead of trying to replace it. Although wasm modules themselves can largely
only manipulate numbers directly, they can import any arbitrary function which
gives wasm full access to the web platform, DOM and all. From day one
WebAssembly is all about reusing and enhancing the web platform experience,
avoiding the need to reinvent the wheel for new functionality.

The threads proposal for wasm is no exception to this pattern! The web already
has support for multithreaded web applications through [Web Workers], and this
is exactly what's used to introduce multithreaded execution to WebAssembly.

Web Workers, however, provide very limited ability to share resources between
threads. Communication and synchronization is done through message passing
([`postMessage`]), but you can only send values that support [structured
cloning]. In Rust-ic terms, very few types in JS are `Send` and you always
`Clone` when sending an object to another thread.

Our goal is to share resources though! It turns out that one of the types
which supports structured cloning is [`WebAssembly.Module`]. Execution of wasm
on the web today requires usage of the wasm JS API, where you create a
[`WebAssembly.Module`] that is akin to the text and data sections of an
executable (compiled code) and then you create a [`WebAssembly.Instance`] from
that module, which is where you actually get things like a heap and a stack.
Already today we can pass a [`WebAssembly.Module`] between threads, and despite
having to `Clone` it between threads it looks roughly like this in most engines:

```rust
pub struct Module {
    contents: Arc<ModuleContents>,
}

// ...
```

which means that the clone operation is quite cheap!

Sharing our code is only half the story, though. Many languages (including Rust)
also rely on *shared memory* as a primitive to build all sorts of concurrency
paradigms like message passing or mutexes.

#### Shared Memory

Continuing the theme of "no fundamental new features just for wasm", shared
memory is fundamentally built on an already stable (or rather, becoming stable)
JS API: [`SharedArrayBuffer`]. A [`SharedArrayBuffer`] is like an
[`ArrayBuffer`] except it's, well, shared! This manifests itself through the
structured cloning algorithm where you can think of it as similar to a
[`WebAssembly.Module`], internally containing an [`Arc`] that's cheap to clone.

Using [`SharedArrayBuffer`] JS can already share memory between workers and the
main thread, making it cheap to compute a large chunk of data and send it to
another thread. (Or at least removes the need to copy data between threads).

WebAssembly modules today are optionally associated with at most one instance of
["linear memory"][`WebAssembly.Memory`]. In non-wasm parlance, you can put a
stick of RAM into a wasm module. This [`WebAssembly.Memory`] is today always
backed by an [`ArrayBuffer`], but you'll soon be able to flag a memory as
"shared" which means it's backed by [`SharedArrayBuffer`] instead. This
subsequently means that the structured clone of a [`WebAssembly.Memory`] backed
by a [`SharedArrayBuffer`] will refer to the same memory!

At this point the pieces are definitely starting to come together. We can
already share modules (code) between threads, and soon we'll be able to share
memory between threads as well! With these new abilities we can instantiate a
[`WebAssembly.Module`] on multiple web workers quickly and efficiently which all
have access to the same memory.

#### Initializing Memory Once

One fun aspect of WebAssembly modules is that memory is automatically
initialized for you. Let's say, for example, you've got a Rust program that
looks like:

```rust
#[no_mangle]
pub extern fn get_data() -> *const u8 {
    "the data".as_ptr()
}
```

If we call that from JS, and if we read the pointer returned, we'll actually see
`the data`! Who actually wrote those bytes to linear memory, though? Each wasm
module can have [data segments] which specify a blob of bytes that is located at
an offset in memory. Upon instantiation of a module, the wasm runtime will copy
each of these data segments to the offset specified into linear memory.

But wait, that's not a good idea if we instantiate our module on multiple
threads! Let's say we have code that looks like:

```rust
#[no_mangle]
pub extern fn get_ticket() -> usize {
    static TICKET: AtomicUsize = AtomicUsize::new(1);
    TICKET.fetch_add(1, SeqCst)
}
```

Here we'll have a data segment consisting of `1usize`, which is three zero bytes
and then a one byte. Each time we instantiate our module we're resetting this
counter back to 1 by overwriting the previous value! What we instead want to
happen is the *first* thread initializes memory and all other threads should
just use what's already there.

To handle this problem, we turn to the [bulk memory operations proposal][bulk].
While the bulk memory operations proposal largely started as a native method of
doing `memcpy` and `memset`, it's now also picked up the ability for "passive
memory segments" which solves the exact problem we're having here.

Each data segment can be flagged as "passive" which means it's not automatically
copied into memory on instantiation. Instead a module must manually initialize
memory via the `memory.init` instruction. Using `memory.init` we can copy memory
from any data segment into any location in memory.

With `memory.init` we at least have the ability to solve the
multi-initialization problem, but it's not entirely clear how we'll leverage
this yet in the toolchain. More on this later!

#### Existing WebAssembly Features and Threads

That about wraps up the new features proposed in the WebAssembly threads (and
bulk memory) proposal. Before we go into how this is all actually going to be
used, though, it's worth taking a quick look at some of the existing features of
WebAssembly and what they mean in a world with threads.

The first interesting aspect (which we'll leverage later on) is the [`start`]
function. WebAssembly modules can flag a function as automatically executed
whenever the module is instantiated. This `start` function can do things like
static initialization or maybe even the `main` function of a
wasm-pretending-to-be-an-executable, but it's not currently exposed or used in
Rust. The semantics of the `start` function don't change at all in the threads
proposal, but it means that it's no longer one time initialization! Instead the
`start` function is still run per-instance, and since we're creating multiple
instances on multiple web workers, the `start` function becomes more like a
"thread init" than a "global init". More on this later!

Next let's take a look at [`global`] variables. Note that these are not Rust
`static` variables (like `TICKET` above) which are compiled as being located in
linear memory. Rust actually provides no ability to create, get, or set custom
`global` variables today, so this is largely an unexposed feature of WebAssembly
in Rust. In WebAssembly, however, a `global` is what its name implies, a global
variable for the instance which can be get, set, and even exported to JS! A
global is more like a virtual register than linear memory because it can only
contain a fixed set of types.

Interestingly, though, globals are per instance. This means that in a world of
multiple instances, they're not actually globals but rather thread locals! Each
of our wasm instances will have its own set of globals that can't be accessed by
other instances, giving us the foundation for thread-local data. More on this
later as well!

Tables in WebAssembly likely also have fun use cases in a threaded wasm world,
but I'm not so sure what those are myself and so for now we'll largely ignore
them. Other than that, that should cover most wasm features and how they relate
to threads!

### Using Threads in Rust

Now that we've gone over the highlights of WebAssembly threads proposal, you
might feel how I felt when I first read it. Sure all those
features sound great, but how is this going to be safely and ergonomically
exposed at the language level? Some problems are nicely self-contained like the
[implementation of `Mutex` in Rust][rust-mutex], but there's a host of other
problems which aren't quite as self contained like:

* First up, stacks! LLVM, Rust's code generator, assumes that it not only gets
  to use the native wasm stack (which is per instance and hence "thread local")
  but also a linear memory stack as well. This means we need a stack pointer
  into linear memory (which LLVM already conveniently places in a `global`)
  which is unique per thread, and someone's gonna have to allocate those stacks
  for each thread.

* Next up, thread local data. We've got the foundations of thread locals with
  `global` variables, but as mentioned before Rust (and LLVM or LLD) doesn't
  actually provide the ability to manipulate or work with custom `global`
  variables. How are we going to implement the standard library's
  [`thread_local!`] macro in Rust?

* We talked a bit about memory initialization earlier and how we don't want to
  reinitialize and wipe out memory, but who's actually doing that? Presumably
  all our data segments need to be `passive` but who's executing `memory.init`
  safely?

* How are we actually going to spawn threads? Whose responsibility is it to
  actually create a web worker? Similarly, by what mechanism is the
  [`WebAssembly.Module`] and [`WebAssembly.Memory`] getting transferred between
  workers and instantiated in the right place?

* When using tools like `wasm-bindgen`, how does the shim JS make its way to all
  the workers which have an instance of wasm? This wrapper JS is needed to make
  calling Rust ergonomic, and we don't want to bless the main thread too much!

Unfortunately we don't have answers to all these questions today. These
questions are also somewhat intertwined together when we don't want them to be!

Rust's vision for WebAssembly on the web is one of interoperability. You should
be able to use Rust and WebAssembly without the rest of your application even
needing to know. Furthermore, a crate deep in your dependency graph may depend
on JS functionality (like an NPM package or [`web-sys`]) and you also shouldn't
need to know about that!

It's not clear if we can maintain this vision for threads on the web platform
right now. This is where I'd love to brainstorm with others and/or get help and
thoughts about this. The threads proposal isn't stable after all, and there's in
theory lots of runway for us to figure out something to help us out!

I'd hate to leave you with a cliffhanger like this, though! While not all of the
above questions have great answers today, I've been working on at least a
*functioning* solution to many of the issues in `wasm-bindgen` specifically. Let's take
a look at that and see if we can actually demo threads and WebAssembly today!

### Threads and `wasm-bindgen`

The [`wasm-bindgen`] tool is composed of two halves. One half is a [procedural
macro], the `#[wasm_bindgen]` attribute, which is expanded and runs at compile
time. This generates shims in your Rust code and otherwise preps the final
binary for the second half, the `wasm-bindgen` CLI.  The CLI tool `wasm-bindgen`
is uniquely positioned to do all sorts of crazy transformations on the
WebAssembly module (and it [already
does](https://github.com/rustwasm/wasm-bindgen/pull/124)!).

The WebAssembly binary format is [well specified][binary-format] and
surprisingly easy to manipulate. The `wasm-bindgen` CLI tool is currently using
the excellent [`parity-wasm`] crate for parsing WebAssembly, which makes it a
breeze for `wasm-bindgen` to do fancy transformations. (and more news on this
soon, an *even breezier* solution is in the works too!)

With the CLI tool and [`parity-wasm`] we're freed from the "shackles" of LLVM
(aka it's easier to experiment in tooling than in LLVM itself) and have access
to the full feature set of WebAssembly. Let's knock out some of those above
questions with this newfound power.

#### Injecting thread-local `global`s

Although LLVM/LLD don't currently have the ability to emit custom `global`
variables, we do in `wasm-bindgen`! This is an easy method to implement
thread-local storage, so let's have `wasm-bindgen` inject two globals:

1. First, a thread ID. Thread IDs can be useful for a number of applications,
   but we're specifically interested in the [`ReentrantMutex`] of the standard
   library right now, which needs to know which thread is which to know when
   reentrant locks are used.

2. Next, a TCB slot. A TCB is a "thread control block" and is typically used to
   store an allocated structure in threading runtimes. This allocated structure
   is an entry point for lots of other runtime-related functionality, but for
   now we'll primarily use this as storage for user-defined thread-local
   values. Or, in other words, this is how we'll implement [`thread_local!`].

It's easy enough to add two `global` variables of type `i32` to the wasm module,
but we need to manage them too! Someone still has to actually allocate the thread
ID, and we also need to be able to access it.

For this let's take another trick of out `wasm-bindgen`'s playbook, rewriting
function calls. We define that a function imported like this:

```rust
#[link(wasm_import_module = "__wbindgen_thread_xform__")]
extern {
    fn __wbindgen_thread_id() -> u32;
}
```

is actually magically turned into `get_global $thread_id`. The `call`
instruction actually has a 1:1 replacement with `get_global`, so the rewriting
here is super simple! We can use similar "intrinsics" like `__wbindgen_tcb_get`
and `__wbindgen_tcb_set` for getting/setting the TCB as well.

Next up, let's figure out how to initialize this thread ID global.

#### Where to `start`?

We saw earlier that WebAssembly provides a `start` function which is
automatically invoked whenever a module is instantiated, and in a multithreaded
world this is per-thread initialization. That's actually exactly what we want
for thread ID initialization as well as other aspects!

Using `wasm-bindgen` we can solve a good number of the above problems with an
injected `start` function. We can even call the previous `start` function when
we're done to preserve semantic equivalence! Our injected function will perform
these steps:

1. Atomically increment an injected global thread ID counter. We reserve 4 bytes
   of space in linear memory for this in `wasm-bindgen`, and this address will
   keep track of all threads that have ever been. The result of this atomic
   addition can then be stored in our thread ID global, meaning we've just
   allocated and initialized our thread ID!

2. We know we're the first thread (the main thread) if our thread ID is zero.
   This is a great time to initialize memory, so `wasm-bindgen` can flag all our
   data segments as `passive`, and if our ID is 0 we can call `memory.init`.

3. If our thread ID isn't 0, then we know that we're a spawned thread. LLVM
   already arranged for there to be a `global` for our stack pointer, but its
   initial value is only valid for the main thread. To keep going we need to set
   this up. To allocate a stack we can leverage the convenient `memory.grow`
   instruction, a quick-and-dirty way to allocate memory without using the
   standard library's actual memory allocator (which to invoke would in turn
   need a stack). Once we've got a stack we can update our stack pointer global,
   and we should be good to go!

4. Finally, if a previous `start` function was available, we can delegate to it
   at this point and call it.

Ok we're making some good progress! By assuming that exactly the same
[`WebAssembly.Module`] is used on all threads, an injected `start` function can
cover a lot of ground to making threads and was easy to use.

#### Managing `WebAssembly.Memory`

By default all Rust-compiled wasm binaries will *export* the `memory` that they
define. This means that the instantiation of a wasm module will automatically
create an instance of [`WebAssembly.Memory`] and make it available for use. This
is incompatible with threads, however, where we want all modules to use the same
instance of memory!

Instead we'll need to arrange for memory to be imported not exported. That can
be a bit of a pain to set up and work with, though, so `wasm-bindgen` can
continue to take care of instantiation in the JS bindings so users don't have to
worry about it.

Note that for now LLVM/LLD also don't currently implement a memory object that's
flagged as `shared`, so as a minor detail `wasm-bindgen` can take care of this
too.

#### Sharing JS shims, spawning Workers

This is where the story with `wasm-bindgen` takes a bit of a nose-dive into
"this particular strategy no longer seems long-term viable" territory. The last
few things we need to take care of is actually spawning the web workers and
somehow getting the [`WebAssembly.Module`] and [`WebAssembly.Memory`] onto each
worker.

I initially attempted to see if we could do this with [Webpack] as it'd be
awesome to have a story for bundlers for large-scale integration. Unfortunately
I ran into a few snags like [you can't access the
`WebAssembly.Module`][webpack-wasm-module] and it also wasn't clear to me how
workers would use a different instantiation path that would `onmessage` to wait
for the module/memory and then instantiate after receiving. Fear not, though, I'm
sure we'll figure out a bundler story for this one way or another!

Next I turned to `wasm-bindgen`'s [`--no-modules`] option to see if something
could work. Currently it exports a global (named `wasm_bindgen`) which is a
function that takes the path to the wasm file to instantiate. I extended it to
take either this or a [`WebAssembly.Module`] instance (along with
[`WebAssembly.Memory`]). That way when given a path it can create memory and do
fetch/instantiate, but with a [`WebAssembly.Module`] it can avoid the fetch and
use the provided memory to instantiate.

Since `--no-modules` makes it setting up everything pretty manual anyway it was
easy enough to have the main thread work as usual, provide accessors for the
module/memory, spin up web workers, and post the module/memory to each worker.
Inside the workers we can import the `--no-modules` generated JS, wait for the
message, wait for instantiation, and then start doing some work.

All-in-all this setup made it so *something* could work. This definitely isn't a
long-term solution as there's no path to use bundlers or runtimes like node.js
yet. We'll surely flesh out all these details before wasm threads are stable
though!

### Demo: Raytracing

Phew! That was quite a lot of information and background, but hopefully you've
got a better idea about what the threads proposal is and some ideas of how we
can leverage it in Rust and `wasm-bindgen`. Let's get to the good stuff now.

We initially strived to have a cool [Mandelbrot Set][mandelbrot] rendering using
[Rayon], but unfortunately the limitations with spawning Web Workers meant we
[couldn't use Rayon][rayon-issue]. Coupled with my own short attention span and
lack of understanding about Mandelbrot, I switched to raytracing!

Having not worked with raytracing in years I googled around to see if there were
any existing Rust raytracers I could try out. [My favorite one I found][tray]
unfortunately requires nightly and last compiled mid-2017, but [@bheisler] had
an [awesome tutorial][ray-tutorial] around early-2017, and the [associated
code][ray-code] still compiles and works today (yay!). After [a few
inconsequential modifications][ray-patches] I was able to use the project *as
is* on the web.

> As a side note, this is one of the awesome aspects of Rust and Cargo. It took
> no time at all to find a raytracer, integrate it, compile it to wasm, and
> run in a browser.

With raytracing (or at least how this raytracer worked) it's an embarrassingly
parallel task as all pixels of an image are rendered entirely independently of
all others. This meant we could rig up a way to [fan out work for pixels amongst
worker threads][worker-threads] pretty easily.

The last piece I thought would be pretty cool for this demo is to see a
progressive rendering to see what an image looks like as it's being rendered.
Every so often the main thread will request an update of the worker threads, and
[they'll send an `ImageData` to the main thread][post-image-data] which can be
rendered to a canvas:

[![Demo preview][gif]][demo]

[Check out the raytracing demo for yourself!][demo] or [browse the code
online][demo-code]

For this demo remember that this is a lot of unstable and nightly technology.
It only works in Firefox (as of this writing) as other browsers don't implement
`memory.init` instructions yet.

You'll find a giant JSON blob on the left which is a description of the scene to
render. Right now it's a pretty simplistic raytracer so it only supports planes
and spheres, but you can move things around, add spheres, etc. If you're willing
I'd love to get some help to [implement more complicated renders as
well](https://github.com/Twinklebear/tray_rust#sample-renders).

### Future Work

While we've gotten to the point of making a demo, we've still got a good deal of
work to do! These are some of the highlights of the remaining tasks.

#### Main Thread Disallows `atomic.wait`

The main thread of the browser cannot execute the `atomic.wait` instruction, it
will unconditionally throw an exception if this is executed. This means that,
by default, mutexes will not work when contended on the main thread!
Additionally, it means that **the only way currently to synchronize with the
main thread is `postMessage` in a worker**.

This situation is especially exacerbated by the fact that Rust's global
allocator, [dlmalloc], is globally synchronized. This means that if your main
thread allocates memory, it may occasionally throw an exception if contended!
This is actually a bug in the demo above today too!

I've [opened an issue](https://github.com/WebAssembly/threads/issues/106) on the
threads proposal repo to discuss this, and hopefully we can figure out a
reasonable workaround for the main thread to at least still allocate memory!
So far I've learned about a proposal for [`Atomics.waitAsync`] which is a second
mechanism to wake up the main thread. There's also thoughts about a custom
allocator which is largely lock-free but falls back to `memory.grow` on the main
thread during contention. In the meantime though this makes it very difficult
for a main thread to use arbitrary libraries on crates.io, as they'd have to be
audited for *any* synchronization.

A "workaround" we may implement for Rust would be to simply spin instead of
`atomic.wait` in the mutex implementation if the thread id is 0. Apart from
being a bad way to synchronize, it also bakes in that the first instantiation
was always on the main thread, which may not always be true!

#### Threads Exit isn't implemented

Right now in the model here for Rust there's not really a concept of a thread
exiting. This means that if a thread does actually exit (aka the worker is gc'd)
then it leaks memory allocations like:

* The thread's stack (it's never reclaimed or reused)
* All data in thread local storage (Rust doesn't register destructors)

Eventually we'll need to add the concept of thread exit so we can correctly
handle this situation and reclaim resources for reuse later. This may be a case
where the [`WeakRef` proposal](https://github.com/tc39/proposal-weakrefs) could
help out though by automatically running a thread exit when js objects are gc'd.

#### Stack overflow is bad again

When laying out linear memory, LLD will by default place static data first and
then the main thread's stack. This has a problem, though, that if the main
thread has a stack overflow it'll silently corrupt all static data! To fix this
problem we pass `--stack-first` to LLD which places, well, the stack first in
memory, causing a stack overflow to trap because of an out of bounds memory
access.

We unfortunately don't have this luxury for all worker threads, though. Worker
threads suffer the same problem as before where if a stack overflow happens
it'll silently corrupt heap or static data.

One option available to us is to insert a prologue (by LLVM or `wasm-bindgen`)
to check whether we have enough linear stack space before decrementing the stack
pointer (trapping if we don't), but it's not clear what sort of performance
impact this change might have as it affects all functions! Alternative solutions
are likely to require new wasm features like unmapping memory to force
operations to trap.

### You can make sausage too!

If you're curious about how the sausage is made and/or how you can help out,
here's a list of changes made to build this demo and some helpful repositories!

* [The bulk memory operations overview was clarified wrt semantics and
  encoding](https://github.com/WebAssembly/bulk-memory-operations/pull/32/files)
* [The `wabt` suite now has support for bulk memory operation
  instructions](https://github.com/WebAssembly/wabt/pull/927)
* [`parity-wasm` now has support for bulk memory
  operations](https://github.com/paritytech/parity-wasm/pull/227)
* [Synchronize the global allocator in Rust's standard
  library](https://github.com/rust-lang/rust/pull/54950)
* [Implement thread local storage for Rust's standard
  library](https://github.com/rust-lang/rust/pull/54951)
* [Fix generated `wasm-bindgen` JS is APIs don't exist (necessary for
  instantiation in Web
  Workers)](https://github.com/rustwasm/wasm-bindgen/pull/959)
* [Switch to using a thread local for `global()`'s cache in
  `js-sys`](https://github.com/rustwasm/wasm-bindgen/pull/958)
* [Add `#[derive(Debug, Clone)]` to
  `js_sys::Promise`](https://github.com/rustwasm/wasm-bindgen/pull/957)
* [Add `TypedArray.slice` bindings to
  `js-sys`](https://github.com/rustwasm/wasm-bindgen/pull/956)
* [Ensure `JsValue` isn't
  `Send`](https://github.com/rustwasm/wasm-bindgen/pull/955)
* [Fix and edge case where futures on the main thread didn't
  complete](https://github.com/rustwasm/wasm-bindgen/pull/954)
* [Initial implementation of wasm32 atomics in Rust's standard
  library](https://github.com/rust-lang/rust/pull/54017)
* [Optimize intrinsics on wasm32 in
  `libm`](https://github.com/japaric/libm/pull/152)
* [Firefox's decoding of `memory.init` needed an update][firefox-spec-bug]
* [Implement support for WebAssembly threads in
  `wasm-bindgen`](https://github.com/rustwasm/wasm-bindgen/pull/972)

If you've gotten this far then you can probably tell that the threads story in
Rust still needs some work! We'd love to have your help and feel free to drop by
at `#rust-wasm` on Mozilla's IRC, [`#wg-wasm` on
Discord](https://discord.gg/6SHrCn), or follow along on GitHub with either
[`wasm-bindgen`] or [`wasm-pack`].

[end]: #demo-raytracing
[demo-code]: https://github.com/rustwasm/wasm-bindgen/tree/master/examples/raytrace-parallel
[worker-threads]: https://github.com/rustwasm/wasm-bindgen/blob/cb170ef94f6013af247e13b50d24a97c473b1a99/examples/raytrace-parallel/src/lib.rs#L286-L320
[post-image-data]: https://github.com/rustwasm/wasm-bindgen/blob/cb170ef94f6013af247e13b50d24a97c473b1a99/examples/raytrace-parallel/src/lib.rs#L333-L363
[gif]: ../../../assets/2018-10-24-rust-wasm-threads.gif
[demo]: https://rustwasm.github.io/wasm-bindgen/exbuild/raytrace-parallel/
[MVP]: https://en.wikipedia.org/wiki/Minimum_viable_product
[`wasm-pack`]: https://github.com/rustwasm/wasm-pack
[`wasm-bindgen`]: https://github.com/rustwasm/wasm-bindgen
[spec]: https://webassembly.github.io/spec/
[threads]: https://github.com/WebAssembly/threads
[vuln]: https://meltdownattack.com/
[`SharedArrayBuffer`]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/SharedArrayBuffer
[wacg]: https://www.w3.org/community/webassembly/
[atomics]: https://github.com/WebAssembly/threads/blob/master/proposals/threads/Overview.md#atomic-memory-accesses
[`AtomicUsize`]: https://doc.rust-lang.org/std/sync/atomic/struct.AtomicUsize.html
[wasm-singlethread]: https://github.com/rust-lang/rust/blob/f51752774bbbe48d2aabe53c86e9e91ed3a73a5d/src/librustc_target/spec/wasm32_unknown_unknown.rs#L46-L48
[futexes]: https://en.wikipedia.org/wiki/Futex
[mutex-example]: https://github.com/WebAssembly/threads/blob/master/proposals/threads/Overview.md#example
[rust-mutex]: https://github.com/rust-lang/rust/blob/f51752774bbbe48d2aabe53c86e9e91ed3a73a5d/src/libstd/sys/wasm/mutex_atomics.rs#L27-L71
[`WebAssembly.Memory`]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WebAssembly/Memory
[Web Workers]: https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API
[`postMessage`]: https://developer.mozilla.org/en-US/docs/Web/API/Worker/postMessage
[structured cloning]: https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API/Structured_clone_algorithm
[`WebAssembly.Module`]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WebAssembly/Module
[`WebAssembly.Instance`]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WebAssembly/Instance
[data segments]: http://webassembly.github.io/spec/core/syntax/modules.html#data-segments
[bulk]: https://github.com/WebAssembly/bulk-memory-operations
[`web-sys`]: https://rustwasm.github.io/wasm-bindgen/api/web_sys/
[binary-format]: http://webassembly.github.io/spec/core/binary/index.html
[`parity-wasm`]: https://github.com/paritytech/parity-wasm
[`ReentrantMutex`]: https://github.com/rust-lang/rust/blob/f51752774bbbe48d2aabe53c86e9e91ed3a73a5d/src/libstd/sys/wasm/mutex_atomics.rs#L81-L160
[Webpack]: https://webpack.js.org/
[webpack-wasm-module]: https://github.com/webpack/webpack/issues/8157
[`--no-modules`]: https://rustwasm.github.io/wasm-bindgen/reference/no-esm.html
[mandelbrot]: https://en.wikipedia.org/wiki/Mandelbrot_set
[Rayon]: https://github.com/rayon-rs/rayon
[rayon-issue]: https://github.com/rayon-rs/rayon/issues/93
[tray]: https://github.com/Twinklebear/tray_rust
[@bheisler]: https://github.com/bheisler
[ray-tutorial]: https://bheisler.github.io/post/writing-raytracer-in-rust-part-1/
[ray-code]: https://github.com/bheisler/raytracer
[ray-patches]: https://github.com/alexcrichton/raytracer/compare/master...update-deps
[firefox-spec-bug]: https://bugzilla.mozilla.org/show_bug.cgi?id=1496582
[dlmalloc]: https://github.com/alexcrichton/dlmalloc-rs
[wait-and-notify]: https://github.com/WebAssembly/threads/blob/master/proposals/threads/Overview.md#wait-and-notify-operators
[`i32.atomic.wait`]: https://github.com/WebAssembly/threads/blob/master/proposals/threads/Overview.md#wait
[`atomic.notify`]: https://github.com/WebAssembly/threads/blob/master/proposals/threads/Overview.md#notify
[`ArrayBuffer`]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/ArrayBuffer
[`Arc`]: https://doc.rust-lang.org/std/sync/struct.Arc.html
[`start`]: http://webassembly.github.io/spec/core/syntax/modules.html#start-function
[`global`]: http://webassembly.github.io/spec/core/syntax/modules.html#globals
[`thread_local!`]: https://doc.rust-lang.org/std/macro.thread_local.html
[procedural macro]: https://doc.rust-lang.org/nightly/reference/procedural-macros.html
[`wasm-opt`]: https://github.com/webassembly/binaryen
[`Atomics.waitAsync`]: https://github.com/tc39/proposal-atomics-wait-async
[post-mvp]: https://hacks.mozilla.org/2018/10/webassemblys-post-mvp-future/
