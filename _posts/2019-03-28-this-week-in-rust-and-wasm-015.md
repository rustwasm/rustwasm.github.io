---
title:  "This Week in Rust and WebAssembly 15"
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

**Want to get involved in Rust and WebAssembly? [Join the Rust and WebAssembly working group!][get-involved]**

## News and Blog Posts from Around the Web

*Want to make sure something ends up on this list next time we publish an issue?
[Leave a comment on this issue.](https://github.com/rustwasm/team/issues/79)*

* [**Standardizing WASI: A system interface to run WebAssembly outside the
  web**](https://hacks.mozilla.org/2019/03/standardizing-wasi-a-webassembly-system-interface/)
  * @alexcrichton already has a pull request to [add a `wasm32-unknown-wasi`
    target](https://github.com/rust-lang/rust/pull/59464) for Rust!
* `RustVolley` is a reimplementation of the Blobby Volley 2 game in Rust and Wasm
  * [Source](https://github.com/RustyVolley/RustyVolleySrc)
  * [Live Demo](https://rustyvolley.github.io/WebDemo/)
* [CloudFlare's new `wrangler` CLI tool lets you deploy Rust-generated Wasm on
  CloudFlare workers](https://blog.cloudflare.com/introducing-wrangler-cli/)
* [Fastly open sources Lucet: a native WebAssembly compiler and
  runtime.](https://www.fastly.com/blog/announcing-lucet-fastly-native-webassembly-compiler-runtime)
  Its built with Rust on top of Cranelift and supports WASI.

## Updates from [`rustwasm/*`](https://github.com/rustwasm)

[**🎉 Welcome @Pauan to the Rust and WebAssembly working group core
team! 🎉**](https://internals.rust-lang.org/t/welcome-pauan-to-the-rust-and-webassembly-domain-working-group-core-team/9707)

### RFCs

#### New RFCs

None.

#### Final Comment Period RFCs

* [Add an amendment to the RFC process](https://github.com/rustwasm/rfcs/pull/9)

#### Merged RFCs

None.

### Working Group Meetings

* [Watch the recording of this week's working group meeting on
  YouTube](https://www.youtube.com/watch?v=gaTwOc0eGb4)
* [Come join us at next week's working group
  meeting!](https://github.com/rustwasm/team/issues/264)

### Gloo

* [**Gloo Update: Onion Layers, Timers, and
  Events**](https://rustwasm.github.io/2019/03/26/gloo-onion-layers.html)
* @Aehmlo [split up the `gloo_timers` crate's public
  API](https://github.com/rustwasm/gloo/pull/38) to use `callbacks` and
  `futures` submodules, as we collectively agreed upon in other issues.
* @cbrevik [implemented the `gloo_console_timer`
  crate,](https://github.com/rustwasm/gloo/pull/32) which provides scoped
  closures and RAII-style helpers for working with `console.time` and
  `console.timeEnd`.
* @OddCoincidence [updated the `gloo_timers`
  internals](https://github.com/rustwasm/gloo/pull/48) to use
  `wasm_bindgen::closures::Closure::once` for `setTimeout`.
* @RyLev added some initial [Azure Pipelines continuous integration
  tests](https://github.com/rustwasm/gloo/pull/46) for Gloo.
* @David-OConnor added the [skeleton of an `mdbook`
  guide](https://github.com/rustwasm/gloo/pull/45) for Gloo.

### `wasm-bindgen`

* @alexcrichton [tweaked the `no-modules` target's generated JavaScript glue for
  instantiating Wasm
  modules](https://github.com/rustwasm/wasm-bindgen/pull/1384) to support
  CloudFlare workers (and other environments where `x instanceof
  WebAssembly.Module` might fail, like across `<iframe>`s)
* @alexcrichton made it so that our emitted JS glue for reflecting Rust closures
  as JS functions will properly [detect and protect against use-after-free from
  the JS side.](https://github.com/rustwasm/wasm-bindgen/pull/1385)
* @alexcrichton fixed a bug where Rust structs exported as JS [didn't always
  emit the JS classes glue in a deterministic
  order.](https://github.com/rustwasm/wasm-bindgen/pull/1383)
* @fitzgen [made the "without a JS bundler" example use `wasm-pack build
  --target web`,](https://github.com/rustwasm/wasm-bindgen/pull/1382) now that
  its supported in the latest `wasm-pack` release.
* @alexcrichton [cleaned up the `wasm-bindgen` CLI's
  options](https://github.com/rustwasm/wasm-bindgen/pull/1369) to take `--target
  blah` instead of `--blah` (which still exist but are deprecated).
* @stevebob [enabled `mdbook`'s link checking tests for the `wasm-bindgen`
  guide](https://github.com/rustwasm/wasm-bindgen/pull/1358) to our continuous
  integration tests.
* @alexcrichton [implemented
  `rustwasm/rfcs#8`](https://github.com/rustwasm/wasm-bindgen/pull/1305) to
  enable transitive crates dependencies on npm packages.
* @RReverser [added the `constructor`
  property](https://github.com/rustwasm/wasm-bindgen/pull/1403) to
  `js_sys::Object`.
* @alexcrichton [fixed sending large
  `u32`s](https://github.com/rustwasm/wasm-bindgen/pull/1401) from Wasm to JS.
* @RReverser [consistently exposed
  `is_like_none`](https://github.com/rustwasm/wasm-bindgen/pull/1398) for our
  generated JS glue, fixing a bug along the way.
* @RReverser [simplified the ABI
  representation](https://github.com/rustwasm/wasm-bindgen/pull/1397) of
  `Option<char>`.
* @alexcrichton [migrated all the `wasm-bindgen-*`
  crates](https://github.com/rustwasm/wasm-bindgen/pull/1395) to Rust 2018
  edition.
* @RReverser [made iterating over JS objects via the JS iteration protocol
  faster](https://github.com/rustwasm/wasm-bindgen/pull/1393) by removing
  redundant property string decoding.
* @RReverser [made a special version of passing strings from JS to
  Wasm](https://github.com/rustwasm/wasm-bindgen/pull/1391) when we are
  targeting Node.js that is faster than using Node.js's `TextEncoder`
  implementation.

### `wasm-pack`

* @alexcrichton [fixed a panic](https://github.com/rustwasm/wasm-pack/pull/598)
  that could happen when installing the `wasm-bindgen` CLI tool.

## Requests for Contribution

**Want to get involved in Rust and WebAssembly? [Join the Rust and WebAssembly
working group!][get-involved]**

[get-involved]: https://github.com/rustwasm/team/blob/master/README.md#get-involved

### New Good First Issues

* [`wasm-bindgen`: `.d.ts` file for `--web` target does not define the `init()` function](https://github.com/rustwasm/wasm-bindgen/issues/1390)
* [`wasm-bindgen`: Closures should implement `std::fmt::Debug`](https://github.com/rustwasm/wasm-bindgen/issues/1387)
* [Gloo: Help ensure we have tracking issues on file for making utility crates for all Web platform features](https://github.com/rustwasm/gloo/issues/41)

### New "Help Wanted" Issues

* [`wasm-bindgen`: Closures should accept references as arguments](https://github.com/rustwasm/wasm-bindgen/issues/1399)
