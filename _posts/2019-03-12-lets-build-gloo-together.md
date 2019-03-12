---
title: "Let's Build Gloo Together"
author: "Nick Fitzgerald"
---

The Rust and WebAssembly domain working group wants to cultivate a stable,
batteries-available, and production-ready ecosystem for [Rust and Wasm
development in 2019][roadmap].

To further that goal, we are creating [Gloo][], a modular toolkit for building
both:

* small, targeted Wasm modules that integrate into a larger JavaScript system,
  and

* whole Web applications written in Rust.

Gloo's goals for Wasm are similar to what the Async Ecosystem working group's
[Tide][] project intends to do for server-side Web development:

> The name “Tide” refers to “a rising tide lifts all boats”; the intent is to
> improve sharing, compatibility, and improvements across all web development
> and frameworks in Rust.

## The Utility High-Level Libraries and Frameworks Provide

We use high-level libraries and frameworks instead of using Web APIs directly
because we want abstractions with which we can naturally express ourselves. We
outsource non-business logic concerns so that we can create more robust
libraries and applications more quickly than we otherwise would. For example,
the desires people might have include:

* They prefer describing how they want the DOM to look like right now, rather
  than enumerating a list of modifications that will transform its current state
  into their desired state. Therefore, they use an immediate-mode virtual DOM
  library.

* They prefer thinking in terms of Rust types, not about the raw, serialized
  bytes in a `fetch`ed HTTP response body or about object stores in Indexed DB.
  Therefore, they use `derive`-based serialization and deserialization with
  `serde`.

There are many different ways to approach high-level APIs, and people have lots
of differing opinions about which way is best! Designing these APIs well is
difficult: we have correctness, ergonomic, and performance concerns.

## How Gloo Fits In

Gloo aims to be both a collection of small, focused utility crates and an
umbrella crate that pulls all the utilities together into a single package.

Our goals with Gloo are:

* **To bolster the Rust and WebAssembly crates ecosystem.** Pick and choose
  utility crates even if you aren't using the whole umbrella Gloo crate, or if
  you are using some other Rust and Wasm framework. We have some crates like
  this today &mdash; for example [the `console_log` crate][console_log] &mdash;
  but we would like to intentionally grow more shared utility crates across the
  ecosystem.

* **To wrap these utilities up in an umbrella crate so that your new project can
  hit the ground running.** This umbrella crate will be a thin wrapper around
  the utility crates, and provides defaults wherever multiple (perhaps
  opinionated) choices exist. To keep the umbrella crate small, we should be
  constantly pulling code out into new shared, utility crates. For the more
  opinionated bits, like virtual DOM rendering or web components, the umbrella
  crate should prefer interfaces over implementations, so that different
  implementations with different approaches are swap-able.

Gloo is far from ready right now! The project has only just begun. But we want
to build Gloo as a collective and in an open way, so we are announcing it early
and inviting you to come help us design and build it.

Want to get involved?

* [Join the `#WG-wasm` channel on the Rust Discord server!][discord]
* [Follow the `rustwasm/gloo` repository on GitHub][Gloo]

## Where We're Starting

[At the 2019 Rust All Hands meeting in Berlin][all-hands], we found that it was
useful to categorize Web libraries by whether they were opinionated or not. We
all want idiomatic-Rust wrapper crates around raw `web-sys` timers and
`requestAnimationFrame` etc, and there isn't a *whole lot* of design work that
needs to happen for this. For many of these kinds of crates, we are ready to
dive into implementation. On the other hand, for the more opinionated bits, like
virtual DOMs and state management, we need to do exploratory design work before
committing to a particular approach.

We'll start exploring the design space of the latter group in a series of follow
up blog posts. In the meantime, if you want to get involved, start hacking on
some of the utility crates, or brainstorm about designs, then [check out some of
the issues][issues] on Gloo's GitHub repository.

[roadmap]: https://github.com/rustwasm/rfcs/pull/7
[Gloo]: https://github.com/rustwasm/gloo
[Tide]: https://rustasync.github.io/team/2018/09/11/tide.html
[console_log]: https://crates.io/crates/console_log
[discord]: https://discord.gg/rust-lang
[all-hands]: https://rustwasm.github.io/2019/02/13/this-week-in-rust-and-wasm-010.html#wasm-at-the-2019-rust-all-hands
[issues]: https://github.com/rustwasm/gloo/issues
