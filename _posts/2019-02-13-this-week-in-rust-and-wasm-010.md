---
title:  "This Week in Rust and WebAssembly 10"
---

Hello and welcome to another issue of *This Week in Rust and WebAssembly*!

[Rust](https://rust-lang.org) is a systems language pursuing the trifecta:
safety, concurrency, and speed.

[WebAssembly](http://webassembly.org) is a stack-based virtual machine and
instruction set. It is fast, safe, portable, and part of the open Web
platform. By compiling to WebAssembly, we can run Rust code on the Web!

This is a weekly summary of Rust and WebAssembly's progress and community.

Did we miss something? Tweet to us at [@rustwasm](https://twitter.com/rustwasm)
or [send us a pull request](https://github.com/rustwasm/rustwasm.github.io).

## News and Blog Posts from Around the Web

*Want to make sure something ends up on this list next time we publish an issue?
[Leave a comment on this issue.](https://github.com/rustwasm/team/issues/79)*

* [**Reflecting on Rust and WebAssembly in
  2018**](https://rustwasm.github.io/2018/12/06/reflecting-on-rust-and-wasm-in-2018.html)

* [`wasm-bindgen` &mdash; how does it
  work?!](http://fitzgeraldnick.com/2018/12/02/wasm-bindgen-how-does-it-work.html)

* [Edge programming with Rust and WebAssembly with
  Terrarium](https://www.fastly.com/blog/edge-programming-rust-web-assembly)

* [Embedding WebAssembly in your Rust Application with
  wasmer.io](https://medium.com/wasmer/executing-webassembly-in-your-rust-application-d5cd32e8ce46)

* [The `console_log` crate](https://github.com/iamcodemaker/console_log) is a
  backend for [the `log` facade](https://crates.io/crates/log) that pipes logged
  messages to the browser's console.

* [Zemeroth](https://ozkriff.itch.io/zemeroth) is a turn-based hexagonal
  tactical game written in Rust and WebAssembly.

* [An example implementation of react/redux style UI development in Rust with
  `percy`](https://github.com/richardanaya/virtual-dom-rs-counter)

* [Seed](https://github.com/David-OConnor/seed) is a new Wasm framework for Web
  apps.

* [`sendilkumarn/generator-wasm-app`](https://github.com/sendilkumarn/generator-wasm-app)
  is a a Wasm app generator for [Yeoman](https://yeoman.io/).

* [`edvorg/rustsmith`](https://github.com/edvorg/rustmith) is a Rocksmith clone
  for the Web platform built with Rust and WebAssembly.

### `#RustWasm2019` Posts

* [Rust WebAssembly 2019](https://blog.ryanlevick.com/posts/rust-wasm-2019/) by
  Ryan Levick

* [My Rust 2019 Dream: Dominate the
  Web](https://www.reddit.com/r/rust/comments/aac8zk/my_rust_2019_dream_dominate_the_web/)
  by richardanaya

* [Wasm 2019](https://blog.yoshuawuyts.com/wasm-2019/) by Yoshua Wuyts

* [Rust and WebAssembly in
  2019](http://fitzgeraldnick.com/2018/12/14/rust-and-webassembly-in-2019.html)
  by Nick Fitzgerald

* [Non-Web Embeddings for Rust Wasm
  2019](https://medium.com/wasmer/non-web-embeddings-for-rust-wasm-2019-7b290e94f81d)
  by Brandon Fish and wasmer.io

## Wasm at the 2019 Rust All Hands

The 2019 Rust All Hands meetup was in Berlin on February 4<sup>th</sup> through
8<sup>th</sup>. @ag_dubs, @alexcrichton, @fitzgen, and @yoshuawuyts from the
Rust and WebAssembly working group all made it out to discuss some Wasm-related
topics and plan for 2019.

We talked about:

* [The road to `wasm-pack`
  1.0.](https://gist.github.com/fitzgen/23a62ebbd67574b9f6f72e5ac8eaeb67#file-road-to-wasm-pack-1-0-md)
  This meeting was about trying to pin down what we want to ship as part of a
  `wasm-pack` 1.0 release, as well as crystallize `wasm-pack`'s ideal UX.

* [A modular toolkit for
  Wasm.](https://gist.github.com/fitzgen/23a62ebbd67574b9f6f72e5ac8eaeb67#file-modular-toolkit-md)
  There's been a lot of talk in `#RustWasm2019` posts and the 2019 roadmap RFC
  about building a modular toolkit for Wasm apps and libraries. This meeting was
  trying to dig a bit more into the details of what that entails. And naming, of
  course.

* [`cargo` build tasks, hooks, and/or `post-build.rs` for
  Wasm.](https://gist.github.com/fitzgen/23a62ebbd67574b9f6f72e5ac8eaeb67#file-cargo-build-hooks-for-wasm-md)
  Long-term (likely on the timeline of a couple years) we would like the
  experience of building Rust and Wasm projects to be *exactly* the same as
  building normal Rust projects: just `cargo build` and that's it. But there is
  a bunch of stuff that needs to happen for Wasm after `rustc` emits a Wasm
  binary, such as generate JS bindings or run `wasm-opt`. This meeting was about
  how to add some sort of generic build hooks to `cargo` and turn `wasm-pack`
  into an implementation of those generic hooks specifically targeted for Wasm
  development.

* [Multithreading Wasm and
  `rayon`.](https://gist.github.com/fitzgen/23a62ebbd67574b9f6f72e5ac8eaeb67#file-wasm-multithreading-and-rayon-md)
  This meeting was about how we take our experimental Wasm multithreading
  support and turn it into a reliable library that can serve as the foundation
  for multithreading on the Web. @CUViper from the `rayon` team also joined, and
  we made a plan for how to get `rayon` working in Wasm.

## Updates from [`rustwasm/*`](https://github.com/rustwasm)

### RFCs

#### New RFCs

* [**2019 Roadmap**](https://github.com/rustwasm/rfcs/pull/7) &mdash; this is
  your chance to help shape our goals for the year!

* [Add support for local JS snippets in `wasm-bindgen`](https://github.com/rustwasm/rfcs/pull/6)

#### Merged RFCs

None.

### Book

* @DebugSteven [wrote a testing
  section](https://github.com/rustwasm/book/pull/137) for the Game of Life
  tutorial!

### Twiggy🌱

* [**We released Twiggy🌱 0.4.0!
  🎉**](https://github.com/rustwasm/twiggy/blob/master/CHANGELOG.md#040)

* @brson fixed a bug where we would [attempt to demangle things that were not
  C++](https://github.com/rustwasm/twiggy/pull/232) symbols as if they were C++
  symbols.

### `walrus`

* [`walrus` is a new library crate for writing Wasm-to-Wasm
  transformations.](https://github.com/rustwasm/walrus) It will eventually (but
  doesn't yet) preserve DWARF debug info for the Wasm across your
  transformations.

* @alexcrichton got `walrus` [round-tripping all the Wasm spec
  tests](https://github.com/rustwasm/walrus/pull/24) correctly.

* @fitzgen [wrote a simple Wasm
  fuzzer](https://github.com/rustwasm/walrus/pull/45), immediately found a bug,
  and whipped up a fix.

* @alexcrichton refactored instruction parsing to [avoid
  recursion](https://github.com/rustwasm/walrus/pull/48). This means that we
  don't blow the stack in debug builds or when given malicious input.

* We just released `walrus` 0.1.0 on crates.io &mdash; expect more exciting
  things from `walrus` in the future :)

### `wasm-bindgen`

* [**We released `wasm-bindgen` 0.2.29 through 0.2.36!
  🎉**](https://github.com/rustwasm/wasm-bindgen/blob/master/CHANGELOG.md#0236)

* @derekdreery [improved the `std::fmt::Debug` output for
  `JsValue`](https://github.com/rustwasm/wasm-bindgen/pull/1161) so that it
  includes object properties and their values, instead of just `[object
  Object]`.

* @fitzgen made the `wasm-bindgen-test` testing infrastructure [capture more
  `console` logging methods' (`warn`, `info`, etc)
  output](https://github.com/rustwasm/wasm-bindgen/pull/1184) for displaying in
  `stdout`.

* @T5uku5hi [added `#[allow(clippy::all)]` to `wasm-bindgen`'s macro-generated
  code,](https://github.com/rustwasm/wasm-bindgen/pull/1207) so that running
  clippy on crates that use `wasm-bindgen` isn't so noisy.

* @alexcrichton added support for [passing `Option<MyEnum>` back and
  forth](https://github.com/rustwasm/wasm-bindgen/pull/1214) between Wasm and JS
  if `MyEnum` has the `#[wasm_bindgen]` attribute.

* @fitzgen [added the `UnwrapThrowExt`
  trait](https://github.com/rustwasm/wasm-bindgen/pull/1219) to `wasm-bindgen`'s
  prelude. This extension trait adds `unwrap_throw` and `expect_throw` methods
  to `Option<T>` and `Result<T, E>` that have the same behavior as regular
  `unwrap` and `expect` except they throw a JS error on failure instead of
  panicking. This is morally the same, but ends up avoiding the `std::panicking`
  and `std::fmt` infrastructure, resulting in smaller code sizes.

* @alexcrichton [migrated `wasm-bindgen`'s post-`rustc` Wasm
  transformations](https://github.com/rustwasm/wasm-bindgen/pull/1237) to the
  new `walrus` crate! This paves the way for maintaining DWARF debug info
  through `wasm-bindgen`.

* @fitzgen made the `wasm-bindgen-test` runtime capture logged messages in tests
  [via `textContent` instead of
  `innerHTML`](https://github.com/rustwasm/wasm-bindgen/pull/1233), avoiding
  issues when logging HTML strings ;)

### `wasm-pack`

* [**We released `wasm-pack`
  0.6.0! 🎉**](https://github.com/rustwasm/wasm-pack/blob/master/CHANGELOG.md#-060)

* @drager implemented [support for typo
  detection](https://github.com/rustwasm/wasm-pack/pull/446) in `wasm-pack`'s
  `Cargo.toml` section.

* @torkve added support for [passing arbitrary extra CLI arguments through
  `wasm-pack build`](https://github.com/rustwasm/wasm-pack/pull/461) and into
  `cargo build`. For example, to build with all cargo features enabled:
  `wasm-pack build -- --all-features`.

* This inspired @chinedufn to add support for [passing arbitrary extra CLI arguments
  through `wasm-pack test`](https://github.com/rustwasm/wasm-pack/pull/530) and
  into `cargo test`!

* @fitzgen fixed a bug where [the output of `wasm-pack test` was printed
  twice](https://github.com/rustwasm/wasm-pack/pull/521).

* @rhysd added support for [emitting the "homepage"
  field](https://github.com/rustwasm/wasm-pack/pull/531) in our generated
  `package.json` if it is present in the crate's `Cargo.toml`.

* @jscheffner [fixed `wasm-pack`'s fetching of `chromedriver`
  binaries](https://github.com/rustwasm/wasm-pack/pull/537) for headless browser
  testing on Windows.

## Requests for Contribution

*Want to get involved in Rust and WebAssembly? [Join the Rust and WebAssembly
working group!][get-involved]*

* [All issues labeled "good first issue" in the `rustwasm/*` repositories](https://github.com/issues?q=is%3Aopen+is%3Aissue+user%3Arustwasm+archived%3Afalse+label%3A%22good+first+issue%22)

* [All issues labeled "help wanted" in the `rustwasm/*` repositories](https://github.com/issues?q=is%3Aopen+is%3Aissue+user%3Arustwasm+archived%3Afalse+label%3A%22help+wanted%22)

### New "Help Wanted" Issues

* [`wasm-pack` &mdash; docs: add documentation for working with wasm-pack
  outside of template](https://github.com/rustwasm/wasm-pack/issues/533)

* [`wasm-pack` &mdash; installer: do not attempt to install to
  /usr/bin](https://github.com/rustwasm/wasm-pack/issues/470)

[get-involved]: https://github.com/rustwasm/team/blob/master/README.md#get-involved
