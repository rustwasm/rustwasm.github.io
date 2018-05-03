---
layout: post
title:  "This Week in Rust and WebAssembly 001"
date:   2018-04-21 21:15:00 +0200
---
Hello and welcome to another issue of *This Week in Rust and WebAssembly*!

[Rust](http://rust-lang.org) is a systems language pursuing the trifecta: safety, concurrency, and speed.

[Web Assembly](http://webassembly.org) is designed as a portable target for compilation of high-level languages like C/C++/Rust, enabling deployment on the web for client and server applications.

These Weeks in Rust and WebAssembly.

Tweet us at [@rustwasm](https://twitter.com/rustwasm) or send us a pull request. Want to get involved? [We love contributions](https://github.com/rust-lang-nursery/rust-wasm/blob/master/README.md)

## News
* [WebAssembly Studio - Online IDE](https://hacks.mozilla.org/2018/04/sneak-peek-at-webassembly-studio/)
* New, in-depth tutorial: [Conway's Game of Life in Rust and WebAssembly](https://rust-lang-nursery.github.io/rust-wasm/game-of-life/introduction.html). Topics covered include:
    * [Setting up the toolchain and making a hello world](https://rust-lang-nursery.github.io/rust-wasm/game-of-life/setup.html)
    * [Designing Rust programs for WebAssembly](https://rust-lang-nursery.github.io/rust-wasm/game-of-life/implementing.html)
    * [Debugging](https://rust-lang-nursery.github.io/rust-wasm/game-of-life/debugging.html)
    * [Time profiling](https://rust-lang-nursery.github.io/rust-wasm/game-of-life/time-profiling.html)
    * [Code size profiling](https://rust-lang-nursery.github.io/rust-wasm/game-of-life/code-size.html)
* [Svelte was renamed to Twiggy. It is a code size profiler for WebAssembly, written in Rust](https://github.com/rustwasm/twiggy)
    - [Twiggy is integrated into WebAssembly Studio](https://twitter.com/fitzgen/status/987135974160265216)
    - [Analyze bloat from monomorphisation of generic functions](https://github.com/rustwasm/twiggy/pull/40)
* [What will it take to get `ggez` (a lightweight 2D games framework) on WebAssembly?](https://wiki.alopex.li/GgezOnWasm)


## Cool tools to watch out for
* [webchat-client-rs](https://github.com/bzar/webchat-rs)
    - A doodle to create a mostly-rust client-server web app with a shared data model and binary communication over websocket between a server and WebAssembly client built using wasm-bindgen.

## Blog posts
* [NES-Emulator in Rust and WebAssembly](https://medium.com/@bokuweb17/writing-an-nes-emulator-with-rust-and-webassembly-d64de101c49d)
* [Hello wasm-pack!](https://hacks.mozilla.org/2018/04/hello-wasm-pack/)
* [Small WebAssembly binaries with Emscripten](https://kripken.github.io/blog/binaryen/2018/04/18/rust-emscripten.html)


## Crates so far
* [wasm-snip 0.1.2 released](https://crates.io/crates/wasm-snip/0.1.2)
* [wasm_bindgen 0.2.5 released](https://crates.io/crates/wasm-bindgen)
