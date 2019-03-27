---
title: "Gloo Update: Onion Layers, Timers, and Events"
layout: "post"
author: "Nick Fitzgerald"
---

About two weeks ago, we [kicked off][lets-build-gloo] our effort to collectively
build [Gloo][], a modular toolkit for building fast and reliable Web apps and
libraries with Rust and Wasm. We knew we wanted to explicitly cultivate the Rust
and Wasm library ecosystem by spinning out reusable, standalone libraries:
things that would help you out whether you were writing a green-field Web app in
pure-Rust, building your own framework, or surgically inserting some
Rust-generated Wasm into an existing JavaScript project. What was still fuzzy,
and which we didn't know yet, was *how* we were going design and expose these
reusable bits.

## Onion-Layered APIs

I'm pleased to tell you that that after some collaborative discussion in issue
threads, we've come up with a promising approach to designing Gloo APIs, and
we've since formalized it a bit in `CONTRIBUTING.md`. I've nicknamed this
approach "onion-layered" API design.

Briefly, we want to build mid-level abstraction libraries on top of raw `-sys`
bindings, build futures and streams integration on top of the mid-level APIs,
and build high-level APIs on top of all that. But &mdash; crucially &mdash;
every layer should be publicly exposed and reusable.

While this approach to API design is certainly not novel, we want to very
deliberately follow it so that we

* maximize reusability for the larger ecosystem, and
* exercise our mid-level APIs when building higher-level APIs, to ensure their
  generality and suitability for acting as a solid foundation.

As we go through and examine each layer, I'll use [the `setTimeout` and
`setInterval` Web APIs][set-timeout] as a running example.

## The Core: `wasm-bindgen`, `js-sys`, and `web-sys`

The innermost layer are raw bindings built on top of [`wasm-bindgen`, `js-sys`
and `web-sys`][announcing-web-sys]. These bindings are fast, have a light code
size foot print, and are future-compatible with [the host bindings
proposal][host-bindings].

What they are *not* is super ergonomic to use all of the time. Using raw
`web-sys` bindings directly can sometimes feel like making raw `libc` calls
instead of leveraging Rust's nice `std` abstractions.

Here is doing some operation after a 500 millisecond timeout using raw `web-sys`
bindings:

```rust
use wasm_bindgen::{closure::Closure, JsCast};

// Create a Rust `FnOnce` closure that is exposed to JavaScript.
let closure = Closure::once(move || {
    do_some_operation();
});

// Get the JavaScript function that reflects our Rust closure.
let js_val = closure.as_ref();
let js_func = js_val.unchecked_ref::<js_sys::Function>();

// Finally, call the `window.setTimeout` API.
let id = web_sys::window()
    .expect("should have a `window`")
    .set_timeout_with_callback_and_timeout_and_arguments_0(js_func, 500)
    .expect("should set a timeout OK");

// Then, if we ever decide we want to cancel the timeout, we do this:
web_sys::window()
    .expect("should have a `window`")
    .clear_timeout_with_handle(timeout_id);
```

## The `callbacks` Layer

When we look at the raw `web-sys` usage, there is a bit of type conversion
noise, some unfortunate method names, and a handful of `unwrap`s for ignoring
edge-case scenarios where we prefer to fail loudly rather than limp along. We
can clean all these things up with the first of our "mid-level" API layers,
which in the case of timers is the `callbacks` module in the `gloo_timers` crate
(which is also re-exported from the `gloo` umbrella crate as `gloo::timers`).

The first "mid-level" API built on top of the `-sys` bindings exposes all the
same functionality and the same design that the Web does, but uses proper Rust
types. For example, at this layer, instead of taking untyped JavaScript
functions with `js_sys::Function`, we take any `F: FnOnce()`. This layer is
essentially the least opinionated direct API translation to Rust.

```rust
use gloo::timers::callbacks::Timeout;
// Alternatively, we could use the `gloo_timers` crate without the rest of Gloo:
// use gloo_timers::callbacks::Timeout;

// Already, much nicer!
let timeout = Timeout::new(500, move || {
    do_some_operation();
});

// If we ever decide we want to cancel our delayed operation, all we do is drop
// the `timeout` now:
drop(timeout);

// Or if we never want to cancel, we can use `forget`:
timeout.forget();
```

## Layering on Futures and Streams

The next layer to add is integrating with popular traits and libraries in the
Rust ecosystem, like `Future`s or `serde`. For our running `gloo::timers`
example, this means we implement a `Future` backed by `setTimeout`, and a
`Stream` implementation backed by `setInterval`.

```rust
use futures::prelude::*;
use gloo::timers::futures::TimeoutFuture;

// By using futures, we can use all the future combinator methods to build up a
// description of some asynchronous task.
let my_future = TimeoutFuture::new(500)
    .and_then(|_| {
        // Do some operation after 500 milliseconds...
        do_some_operation();

        // and then wait another 500 milliseconds...
        TimeoutFuture::new(500)
    })
    .map(|_| {
        // after which we do another operation!
        do_another_operation();
    })
    .map_err(|err| {
        handle_error(err);
    });

// Spawn our future to run it!
wasm_bindgen_futures::spawn_local(my_future);
```

Note that we use `futures` 0.1 for now, because we've fought tooth and nail to
get the Wasm ecosystem on stable Rust, but as soon as the new
`std::future::Future` design is stable, we plan to switch over. We are very
excited for `async`/`await` as well!

## More Layers?

That's all the layers we have for the `setTimeout` and `setInterval`
APIs. Different Web APIs will have different sets of layers, and this is
fine. Not every Web API uses callbacks, so it doesn't make sense to always have
a `callbacks` module in every Gloo crate. The important part is that we are
actively identifying layers, making them public and reusable, and building
higher-level layers on top of lower-level layers.

We will likely add even higher-level layers to other Web APIs where it makes
sense. For example, the [File API][]'s `FileReader` interface exposes methods
that you shouldn't call until after certain events have fired, and any attempt
to call them earlier will throw. We can codify this as [a state machine-based
`Future`][state-machine-future], that doesn't even give you the ability to call
those methods until after the relevant events have fired and the state machine
reaches a certain state. Leveraging types at compile time for ergonomics and
correctness!

Another future direction is adding more integration layers with more parts of
the larger Rust crates ecosystem. For example, adding functional reactive
programming-style layers via [the `futures-signals`
crate][integrate-futures-signals] which is also used by the
[`dominator`][dominator] framework.

## Events

One of the active bits of design work going on in Gloo right now is how to craft
our event targets and listeners layer. Events are used across most of the Web
APIs, so it is very important we get this design right, as it will sit
underneath many of our other crates. While we haven't 100% nailed down the
design yet, I really like where we are headed.

On top of [`web_sys::Event`][web-sys-event] and
[`web_sys::EventTarget::add_event_listener_with_callback`][web-sys-add-listener],
we are building a layer for [adding and removing event
listeners][raii-listeners] and managing their lifetimes from Rust via RAII-style
automatic cleanup upon drop.

We can use this API to make idiomatic Rust types that attach event listeners
that automatically get removed from the DOM when the type is dropped:

```rust
use futures::sync::oneshot;
use gloo::events::EventListener;

// A prompt for the user.
pub struct Prompt {
    receiver: oneshot::Receiver<String>,

    // Automatically removed from the DOM on drop!
    listener: EventListener,
}

impl Prompt {
    pub fn new() -> Prompt {
        // Create an `<input>` to prompt the user for something and attach it to the DOM.
        let input: web_sys::HtmlInputElement = unimplemented!();

        // Create a oneshot channel for sending/receiving the user's input.
        let (sender, receiver) = oneshot::channel();

        // Attach an event listener to the input element.
        let listener = EventListener::new(&input, "input", move |_event: &web_sys::Event| {
            // Get the input element's value.
            let value = input.value();

            // Send the input value over the oneshot channel.
            sender.send(value)
                .expect_throw(
                    "receiver should not be dropped without first removing DOM listener"
                );
        });

        Prompt {
            receiver,
            listener,
        }
    }
}

// A `Prompt` is also a future, that resolves after the user input!
impl Future for Prompt {
    type Item = String;
    type Error = ();

    fn poll(&mut self) -> Poll<Self::Item, Self::Error> {
        self.receiver
            .poll()
            .map_err(|_| {
                unreachable!(
                    "we don't drop the sender without either sending a value or dropping the whole Prompt"
                )
            })
    }
}
```

On top of that layer, we are using Rust's trait system to design [a
higher-level, static events API][static-events] that will make the events
casting safe and statically-checked, and make sure you don't have typos in the
event types that you listen to:

```rust
use gloo::events::{ClickEvent, on};

// Get an event target from somewhere.
let target: web_sys::EventTarget = unimplemented!();

// Listen to the "click" event, know that you didn't misspell the event as
// "clik", and also get a nicer event type!
let click_listener = on(&target, move |e: &ClickEvent| {
    // The `ClickEvent` type has nice getters for the `MouseEvent` that
    // `"click"` events are guaranteed to yield. No need to dynamically cast
    // an `Event` to a `MouseEvent`.
    let (x, y) = event.mouse_position();

    // ...
});
```

These event APIs are still works in progress and have some kinks to work out,
but I'm very excited for them, and we hope to get a lot of mileage out of them
as we build other Gloo crates that internally use them.

## Get Involved!

Let's build Gloo together! Want to get involved?

* [Join the `#WG-wasm` channel on the Rust Discord server!][discord]
* [Follow the `rustwasm/gloo` repository on GitHub and check out its
  `CONTRIBUTING.md`][Gloo]


[lets-build-gloo]: https://rustwasm.github.io/2019/03/12/lets-build-gloo-together.html
[Gloo]: https://github.com/rustwasm/gloo
[set-timeout]: https://developer.mozilla.org/en-US/docs/Web/API/WindowOrWorkerGlobalScope/setTimeout
[announcing-web-sys]: https://rustwasm.github.io/2018/09/26/announcing-web-sys.html
[host-bindings]: https://github.com/WebAssembly/host-bindings/blob/master/proposals/host-bindings/Overview.md
[state-machine-future]: https://github.com/fitzgen/state_machine_future
[integrate-futures-signals]: https://github.com/rustwasm/gloo/issues/33
[dominator]: https://github.com/Pauan/rust-dominator
[File API]: https://github.com/rustwasm/gloo/issues/47
[web-sys-add-listener]: https://docs.rs/web-sys/0.3.17/web_sys/struct.EventTarget.html#method.add_event_listener_with_callback
[web-sys-event]: https://docs.rs/web-sys/0.3.17/web_sys/struct.Event.html
[raii-listeners]: https://github.com/rustwasm/gloo/issues/30
[static-events]: https://github.com/rustwasm/gloo/issues/43
[discord]: https://discord.gg/rust-lang
