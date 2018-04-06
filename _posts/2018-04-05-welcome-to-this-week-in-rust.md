---
layout: post
title:  "Welcome to this week in Rust and WebAssembly!"
---

Hello and welcome to the first issue of *This Week in Rust and WebAssembly*!

[Rust](https://rust-lang.org) is a systems language pursuing the trifecta: safety, concurrency, and speed.

[WebAssembly](http://webassembly.org) is designed as a portable target for compilation of high-level languages like C, C++, and Rust, enabling deployment on the web for client and server applications.

This is a weekly summary of its progress and community.

Tweet us at [@rustwasm](https://twitter.com/rustwasm) or send us a pull request. Want to get involved? [We love contributions!][get-involved]

[get-involved]: https://github.com/rust-lang-nursery/rust-wasm/blob/master/README.md#get-involved

## News and Releases

* [The `lld` linker landed in nightly Rust!](https://github.com/rust-lang/rust/pull/48125) Expect faster `.wasm` compilation, smaller `.wasm` binaries when using `lto = true`, support for custom `.wasm` sections, and more.

* [`wasm-pack`](https://github.com/ashleygwilliams/wasm-pack) packs up the `.wasm` and publishes it to npm

  > The goal of this project is to create a portable command line tool for publishing compiled wasm projects to the npm registry for the consumption of js devs using the npm CLI, yarn, or any other CLI tool that interfaces with the npm registry.

* [`rust-dominator`](https://crates.io/crates/dominator) is a zero-cost virtual DOM library. It even already has a spec-compliant [TODO-MVC implementation](https://github.com/Pauan/rust-dominator/blob/master/examples/todomvc/src/main.rs)!

* [Kovan](https://wiki.parity.io/WebAssembly-Home) is an Ethereum-like testnet.
    - [Tutorial](https://github.com/paritytech/pwasm-tutorial)
    - [Talks](https://www.youtube.com/watch?v=Adcn-L59LRs)

* [`wasm-sign`](https://github.com/frehberg/wasm-sign) is a WebAssembly signing and verification tool.

* [`edit-text`](https://github.com/tcr/edit-text) is a collaborative text editor built with Rust and WebAssembly.

* [`wasm_bindgen` 0.2.0 released](https://crates.io/crates/wasm-bindgen)
    - Uses the new `#[wasm_custom_section]` attribute to produce by-default smaller binaries
    - JS output is by default compatible with either Node.js or the browser
    - The `--nodejs` flag's output is now natively usable by Node.js, aka uses `require` and loads the WebAssembly module synchronously
    - Lots of internal refactorings in preparation for new features like closures and futures

* [`wee_alloc` 0.2.0 released](https://github.com/fitzgen/wee_alloc/blob/master/CHANGELOG.md#020)

## Articles, Blog Posts, and Talks

* [Come Join the Rust and WebAssembly Working Group!](http://fitzgeraldnick.com/2018/02/27/wasm-domain-working-group.html)

* [Making WebAssembly better for Rust & for all languages](https://hacks.mozilla.org/2018/03/making-webassembly-better-for-rust-for-all-languages/)- [Lin Clark](https://twitter.com/linclark)

* [JavaScript to Rust and Back Again: A `wasm-bindgen` Tale](https://hacks.mozilla.org/2018/04/javascript-to-rust-and-back-again-a-wasm-bindgen-tale/)

* [Speed Without Wizardry](http://fitzgeraldnick.com/2018/02/26/speed-without-wizardry.html)

* [Do things faster and better with WebAssembly](https://speakerdeck.com/sendilkumarn/do-things-faster-and-better-with-webassembly)- [Sendilkumarn](https://twitter.com/sendilkumarn)
    - [video](https://goo.gl/aUhPFW)

## Upcoming Events / Talks

* [Do things faster with WebAssembly @Codemotion 2018 Rome](https://rome2018.codemotionworld.com/talk-detail/?detail=8054) by [Sendilkumarn](https://twitter.com/sendilkumarn)

* [PDXRust: Rust and WebAssembly workshop](https://www.meetup.com/PDXRust/events/249474845/)
