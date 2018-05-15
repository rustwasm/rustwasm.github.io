---
layout: post
title:  "This Week in Rust and WebAssembly 002"
date:   2018-05-14 14:00:00 +0200
---

Hello and welcome to another issue of *This Week in Rust and WebAssembly*!

[Rust](https://rust-lang.org) is a systems language pursuing the trifecta: safety, concurrency, and speed.

[WebAssembly](http://webassembly.org) is a stack-based virtual machine and instruction set. It is fast, safe, portable, and part of the open Web platform. By compiling to WebAssembly, we can run Rust code on the Web!

This is a weekly summary of Rust and WebAssembly's progress and community.

Did we miss something? Tweet to us at [@rustwasm](https://twitter.com/rustwasm) or [send us a pull request](https://github.com/rustwasm/rustwasm.github.io).

**Want to get involved in Rust and WebAssembly? [Join the Rust and WebAssembly working group!][get-involved]**

[get-involved]: https://github.com/rust-lang-nursery/rust-wasm/blob/master/README.md#get-involved

## New Tools, Crates, and Projects
* [Cervus](https://github.com/cervus-v/cervus)
    - Cervus implements a WebAssembly "usermode" on top of the Linux kernel, enabling wasm applications to run directly in ring 0, while still ensuring safety and security.
*  [gutenberg-parser-rs](https://github.com/Hywan/gutenberg-parser-rs)
    - An experimental Rust parser for WordPress Gutenberg post format.
* [wasm-to-rust](https://github.com/CryZe/wasm-to-rust)
    - The wasm-to-rust tool allows you to compile any WebAssembly binary into Rust source code that you can then compile with Rust.
* [wasmboy-rs](https://github.com/CryZe/wasmboy-rs)
    -  Tool to compile a Gameboy emulator written in AssemblyScript (WebAssembly subset of TypeScript) to Rust 

## News and Releases
* [wee_alloc 0.4.0 released](https://github.com/rustwasm/wee_alloc/blob/master/CHANGELOG.md#040)
* [wasm-snip 0.1.3 released](https://github.com/fitzgen/wasm-snip)
* [wasm-pack 0.2.0 released](https://github.com/ashleygwilliams/wasm-pack/releases/tag/v0.2.0)
* [wbg-rand 0.4.0 released](https://crates.io/crates/wbg-rand)
* [twiggy  0.1.0 released](https://crates.io/crates/twiggy)
* [Futures 0.2 support stdweb](https://github.com/koute/stdweb/pull/206)
* [Text adventure / fighting game made with rust and WebAssembly](https://ldjam.com/events/ludum-dare/41/text-em-up)
* [http added WebAssembly to their CI](https://github.com/hyperium/http#198)
* [Replacing JS parser with Rust using WebAssembly resulted 50.8x faster](https://twitter.com/mnt_io/status/994191317923192832)
* [Chrono can be used in your Rust and WebAssembly library](https://github.com/rust-lang-nursery/rust-wasm/issues/169)
* [musl's libm compiled to wasm with clang 7 and then compiled to Rust](https://gist.github.com/CryZe/3daab58b5b4e2e77c37b03a49645e2e3)


## Articles, Blog Posts, and Talks
* [Using LLVM from Rust, to generate WebAssembly](https://medium.com/@jayphelps/using-llvm-from-rust-to-generate-webassembly-93e8c193fdb4)
* [Mozilla packs Rust software for NPM - wasm-pack!](https://www.golem.de/news/wasm-pack-mozilla-packt-rust-software-fuer-npm-1804-133944.html)
* [How does dynamic dispatch (trait objects) work in WebAssembly](http://fitzgeraldnick.com/2018/04/26/how-does-dynamic-dispatch-work-in-wasm.html)
* [Rust and WebAssembly tutorial](https://freemasen.github.io/wasm_tutorial/)
* [Face detection in WebAssembly](https://www.reddit.com/r/rust/comments/8gg7i1/implement_a_face_detectorpicojs_in_rust_and/)
* [A Rust + WebAssembly + Web Workers fractal renderer](https://www.reddit.com/r/rust/comments/8hdq5r/a_rust_javascript_web_workers_fractal_renderer/)


## Requests for Contribution
* Request for library 
    - [slim web component library](https://github.com/rust-lang-nursery/rust-wasm/issues/162)
    - [mpsc channels library built on top of the postMessage API](https://github.com/rust-lang-nursery/rust-wasm/issues/163)
* Request for contributors 
    - [Design a tree-map visualization for twiggy in WebAssembly Studio](https://github.com/wasdk/WebAssemblyStudio/issues/163)
