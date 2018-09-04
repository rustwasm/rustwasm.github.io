---
title:  "This Week in Rust and WebAssembly 007"
---

Hello and welcome to another issue of *This Week in Rust and WebAssembly*!

[Rust](https://rust-lang.org) is a systems language pursuing the trifecta: safety, concurrency, and speed.

[WebAssembly](http://webassembly.org) is a stack-based virtual machine and instruction set. It is fast, safe, portable, and part of the open Web platform. By compiling to WebAssembly, we can run Rust code on the Web!

This is a weekly summary of Rust and WebAssembly's progress and community.

Did we miss something? Tweet to us at [@rustwasm](https://twitter.com/rustwasm) or [send us a pull request](https://github.com/rustwasm/rustwasm.github.io).

**Want to get involved in Rust and WebAssembly? [Join the Rust and WebAssembly working group!][get-involved]**

## New Tools, Crates, and Projects

* [A Sudoku Solver written in Rust and compiled to WebAssembly](https://emerentius.github.io/sudoku_web/)
* [Wasabi: a dynamic analysis framework for WebAssembly](http://wasabi.software-lab.org/)
  * Wasabi is written in Rust and built on top of WABT
* [`greenwasm`](https://github.com/Kimundi/greenwasm) is a WebAssembly engine written in Rust, designed to mirror the standard's specification as closely as possible.

## News and Releases

* [The Game of Life tutorial now uses `wasm-pack` and has a section on publishing your `wasm-game-of-life` package to npm!](https://github.com/rustwasm/book#78)
* [Announcing `wasm-bindgen` 0.2.19](https://github.com/rustwasm/wasm-bindgen/blob/master/CHANGELOG.md#0219-and-0218)
* [Announcing `js-sys` 0.2.4](https://github.com/rustwasm/wasm-bindgen/blob/master/crates/js-sys/CHANGELOG.md#024)

## Articles, Blog Posts, and Talks

* [From Rust to beyond: The WebAssembly Galaxy](https://mnt.io/2018/08/22/from-rust-to-beyond-the-webassembly-galaxy/)
  * [@Hywan](https://github.com/Hywan) wrote a parser for WordPress's Gutenberg
    document format in Rust and WebAssembly, and it is *much* faster than the
    original JavaScript implementation.
* [@sendilkumarn](https://github.com/sendilkumarn) is giving a talk on Rust and WebAssembly at [Rust Amsterdam](https://www.meetup.com/Rust-Amsterdam/events/253425558/)

## Requests for Contribution

* [**Join the Rust and WebAssembly Working Group!**][get-involved]
  * [All issues labeled "good first issue" in the `rustwasm/*` repositories](https://github.com/issues?q=is%3Aopen+is%3Aissue+user%3Arustwasm+archived%3Afalse+label%3A%22good+first+issue%22)
  * [All issues labeled "help wanted" in the `rustwasm/*` repositories](https://github.com/issues?q=is%3Aopen+is%3Aissue+user%3Arustwasm+archived%3Afalse+label%3A%22help+wanted%22)
* [Add wasm-bindgen-futures to crates you should know section](https://github.com/rustwasm/book/issues/81)
* [Expose bindings to *ALL* the global JS things](https://github.com/rustwasm/wasm-bindgen/issues/275)
* Help build the `web-sys` crate by enabling bindings generation for more WebIDL interfaces!
  * [Information on contributing to `web-sys`](https://rustwasm.github.io/wasm-bindgen/web-sys.html)
  * [Issues tracking adding various Web APIs to `web-sys`](https://github.com/rustwasm/wasm-bindgen/issues?q=is%3Aissue+is%3Aopen+label%3Aweb-sys)
* [Add `extends = ...` attributes to `js-sys` types](https://github.com/rustwasm/wasm-bindgen/issues/670)

[get-involved]: https://github.com/rustwasm/team/blob/master/README.md#get-involved
