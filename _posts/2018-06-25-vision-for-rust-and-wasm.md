---
title: Our Vision for Rust and WebAssembly
---

<meta charset="utf-8" />

Rust and WebAssembly can combine in *many* delightful ways. To consolidate our
efforts and have the largest, most-positive impact we can, the Rust and
WebAssembly domain working group is focusing on one vision:

**Surgically inserting Rust compiled to WebAssembly should be the best choice
for speeding up the most performance-sensitive JavaScript code paths. Do *not*
throw away your existing code base, because Rust [plays well with
others][better-for-all]. Regardless of whether you are a Rust or Web developer,
your natural workflow shouldn't change because Rust compiled to wasm integrates
seamlessly into your preferred tools.**

This blog post will expand on these aspirations and describe where we stand in
relation to them right now. In a series of follow up posts, we will talk about
the next steps for each major component of the Rust and WebAssembly ecosystem.

**[Are you interested in helping us make these ideals into reality? Join the
Rust and WebAssembly domain working group!][get-involved]**

## Why Focus on Performance-Sensitive Code?

In the most performance-sensitive contexts, JavaScript hinders rather than
helps. Its dynamic type system and non-deterministic garbage collection pauses
get in the way. Seemingly small code changes can result in drastic performance
regressions if you accidentally wander off the JIT's happy path.

On the other hand, Rust gives programmers low-level control and reliable
performance. It is free from the non-deterministic garbage collection
pauses. Programmers have control over indirection, monomorphization, and memory
layout.

With Rust, we don't need to be a performance gurus who are intimately familiar
with the inner workings of each JavaScript implementation's JIT. We can have
[speed without wizardry][].

## Do <u>Not</u> Rewrite — Integrate

Rust compiled to WebAssembly doesn't have a runtime. This results in small
`.wasm` binary sizes that are proportional to the amount of Rust code that is
being compiled to WebAssembly. Binary size is of huge importance since the
`.wasm` must be downloaded over the network. The proportionality means you only
pay (in code size) for what you use. In turn, that means it is feasible for
existing JavaScript code bases to incrementally and partially adopt Rust.

Keep the code that already works: we can port only our most
performance-sensitive JavaScript functions to Rust and gain immediate benefits.

## Keep Your Workflow

If you are a JavaScript hacker and want to use a library that is written in Rust
and WebAssembly, you shouldn't have to change your workflow at all. We can
publish `.wasm` packages to npm, and you can depend on them in `package.json`
just like you normally would any other JavaScript library. They can be imported
as ECMAScript modules, CommonJS-style `require`s, or added as a new object
property to the JavaScript global. [Bundlers will understand Rust and
WebAssembly][webpack-rust-plugin] just as well as they understand JavaScript.

If you are a Rust hacker and want to compile your crate to `.wasm` and share it
on npm, you shouldn't have to change your workflow either. In fact, you
shouldn't even need to install npm, Node.js, and a whole JavaScript development
environment. `wasm-pack` will compile, optimize, and generate JavaScript
bindings for your crate. And then it will publish it to npm for you too!

## Current Status

This section provides a snapshot of our current ecosystem, the tools that are
available right now, and how this compares to the vision described above.

### The Rust and WebAssembly Book

Everything we build is for naught if people can't learn how to use it
themselves. So we are writing [The Rust and WebAssembly Book][book].

Right now, it already has a lot of great content:

* Getting up and running
* Designing and implementing a non-trivial example (the Game of Life) that
  integrates Rust and JavaScript
* Tips for debugging, time profiling, and code size profiling
* How to publish to npm with `wasm-pack`

But it doesn't have a lot of continuity. It feels like a collection of
appendices and random tutorials. We will have a follow up blog post detailing
its specific needs, and how to help if you're interested.

### wasm-bindgen

[`wasm-bindgen` facilitates communication between Rust and
JavaScript.][wasm-bindgen] You can import JavaScript things into Rust, and
export Rust things to JavaScript. It allows you to send rich types like strings
and structs between wasm and JavaScript, rather than only the simple integers
and floats defined by the WebAssembly standard.

Here is "Hello, World!" between Rust and JavaScript with `wasm-bindgen`. First,
we import the `alert` function into Rust and export the `greet` function to
JavaScript:

```rust
extern crate wasm_bindgen;
use wasm_bindgen::prelude::*;

#[wasm_bindgen]
extern {
    fn alert(s: &str);
}

#[wasm_bindgen]
pub fn greet(name: &str) {
    alert(&format!("Hello, {}!", name));
}
```

Then, we import the wasm as an ECMAScript module in JavaScript, and call the
`greet` function:

```js
import { greet } from "./hello_world";

greet("World!");
```

<a href="/images/wasm-bindgen-architecture-current.png">
  <img src="/images/wasm-bindgen-architecture-current.png" alt="wasm-bindgen architecture" style="float:right;width:50%;min-width:200px;max-width:400px;margin:1em"/>
</a>

How does `wasm-bindgen` work? Simplifying a bit, it is a procedural macro that
takes in Rust source code annotated with `#[wasm_bindgen]` attributes,
constructs an abstract syntax tree (AST), and then it emits two artifacts:

1. Rust bindings that import JavaScript things and export Rust things.

2. JavaScript bindings that expose a nice interface to Rust-exported things to
   other JavaScript code and provide the Rust's desired imports.

`wasm-bindgen`'s approach to JavaScript binding allows you to pay only for the
imports that you use. Just because you imported the `window.alert` function, you
don't end up with glue code for `window.document`.

The big downside is that, right now, you always have to declare imports
yourself. There are common imports for JavaScript functions and types and the
Web platform APIs that will undoubtedly be repeated by many people many times
over. Importing these by-hand is both boring and mechanical. We have a plan for
fixing this, but you'll have to wait for a follow up blog post to learn more.

<div style="clear: both"/>

### wasm-pack

[`wasm-pack` seeks to be a one-stop shop for building, optimizing, and
publishing Rust-generated WebAssembly that you would like to interoperate with
JavaScript, in the browser, or with Node.js.][wasm-pack] `wasm-pack` helps you
build and publish Rust-generated WebAssembly to the npm registry to be used
alongside any other JavaScript package in workflows that you already use, such
as a bundler like [webpack][] or a service like [greenkeeper][].

[![wasm-pack cartoon](/images/wasm-pack-cartoon.png)](/images/wasm-pack-cartoon.png)

*Drawing by Lin Clark in [Making WebAssembly better for Rust & for all
languages][better-for-all]*

The intention is that if you are a Rust developer and want to publish a crate
compiled to wasm on npm, `wasm-pack` will

1. compile the crate to WebAssembly with the `wasm32-unknown-unknown` target,
2. run the `wasm-bindgen` CLI tool on the `.wasm` to generate its JavaScript
   interface,
3. run any other post-build tools such as `wasm-snip` and `wasm-opt`,
4. collate any and all npm dependencies your crate and/or its JavaScript
   bindings might have,
5. and publish the resulting package on npm.

All without you, the Rust developer, needing to have a JavaScript toolchain up
and running.

Right now, steps 1, 2, and 5 are in place, but you still need to have `npm`
installed locally. There are also some more things planned for `wasm-pack`, and
our story for orchestrating builds, dependencies, and publishing coming down the
pipe, but you'll have to wait for the dedicated follow up blog post.

### Wait, There's More!

<a href="/images/twiggy.png">
  <img src="/images/twiggy.png" alt="Twiggy!" style="float:right;width:40%;min-width:100px;max-width:500px;margin:1em"/>
</a>

* [Twiggy is a code size profiler for `.wasm` binaries.][twiggy] It helps you
  answer questions like "why did this function even end up in here -- who calls
  it?" and "how much space would be saved if I stopped using this function,
  removed it, and removed all the functions that become dead code after its
  removal?"

* [`wee_alloc` is a tiny allocator designed for WebAssembly that has a (pre
  compression) code size footprint of only a single kilobyte.][wee_alloc] It is
  geared towards code that makes a handful of initial dynamically sized
  allocations, and then performs its heavy lifting without any further
  allocations. This scenario requires *some* allocator to exist, but we are more
  than happy to trade allocation performance for small code size.

<div style="clear: both"/>

<a href="/images/console_error_panic_hook.png">
  <img src="/images/console_error_panic_hook.png" alt="Twiggy!" style="float:left;width:60%;min-width:100px;max-width:800px;margin:1em"/>
</a>

* [The `console_error_panic_hook` crate provides a panic hook for wasm that logs
  panics to the developer console via the `console.error`
  function.][console_error_panic_hook] No more opaque "RuntimeError: unreachable
  executed" messages! Get the proper assertion failure message or index
  out-of-bounds information you expect. It makes debugging panics a whole lot
  easier.

* [The `wasm-snip` tool lets you forcibly replace a function's body with a
  single `unreachable` instruction.][wasm-snip] Maybe you know that some
  function will never be called at runtime, but the compiler can't prove that at
  compile time? Snip it! Then run wasm-gc again and all the functions it
  transitively called (which could also never be called at runtime) will get
  removed too. This is particularly helpful for removing Rust's panicking and
  formatting infrastructure when you intend to ship small `.wasm` binaries with
  `panic=abort`.

<div style="clear: both"/>

## Coming Soon: The Future

As mentioned throughout this post, we'll be following up with more blog posts
detailing specific goals we have for the Rust 2018 edition and how you can
help. In the meantime, don't hesitate to [join the Rust and WebAssembly domain
working group and help build the future of Rust and WebAssembly now!][get-involved]


[better-for-all]: https://hacks.mozilla.org/2018/03/making-webassembly-better-for-rust-for-all-languages/
[get-involved]: https://github.com/rustwasm/team#get-involved
[speed without wizardry]: http://fitzgeraldnick.com/2018/02/26/speed-without-wizardry.html
[webpack-rust-plugin]: https://github.com/xtuc/rust-plugin
[book]: https://rustwasm.github.io/book/
[host-bindings]: https://github.com/WebAssembly/host-bindings/blob/master/proposals/host-bindings/Overview.md
[wasm-bindgen]: https://github.com/rustwasm/wasm-bindgen
[wasm-pack]: https://github.com/rustwasm/wasm-pack
[wasm-snip]: https://github.com/rustwasm/wasm-snip
[console_error_panic_hook]: https://github.com/rustwasm/console_error_panic_hook
[twiggy]: https://github.com/rustwasm/twiggy
[wee_alloc]: https://github.com/rustwasm/wee_alloc
[webpack]: https://webpack.js.org/
[greenkeeper]: https://greenkeeper.io/
