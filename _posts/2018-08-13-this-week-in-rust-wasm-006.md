---
title:  "This Week in Rust and WebAssembly 006"
---

Hello and welcome to another issue of *This Week in Rust and WebAssembly*!

[Rust](https://rust-lang.org) is a systems language pursuing the trifecta: safety, concurrency, and speed.

[WebAssembly](http://webassembly.org) is a stack-based virtual machine and instruction set. It is fast, safe, portable, and part of the open Web platform. By compiling to WebAssembly, we can run Rust code on the Web!

This is a weekly summary of Rust and WebAssembly's progress and community.

Did we miss something? Tweet to us at [@rustwasm](https://twitter.com/rustwasm) or [send us a pull request](https://github.com/rustwasm/rustwasm.github.io).

**Want to get involved in Rust and WebAssembly? [Join the Rust and WebAssembly working group!][get-involved]**

## New Tools, Crates, and Projects

* [Railway diagram generator for Rust macro_rules! macros with a wasm demo](https://www.reddit.com/r/rust/comments/96q6jb/show_reddit_a_syntaxdiagram_generator_for_macro/)
* [A work-in-progress pull request to expose Wasm SIMD intrinsics to stdsimd](https://github.com/rust-lang-nursery/stdsimd/pull/549)
* WIP prototype of using DWARF debug info in Firefox's debugger.html to debug inlined stack frames in Rust+Wasm programs
  * [gif](https://drive.google.com/file/d/1Yf1gXBSWNdSzXomy8GKUOiPuZVFAASfw/view)
  * WIP spec work: [here](https://yurydelendik.github.io/webassembly-dwarf/) and [here](https://gist.github.com/yurydelendik/802f36983d50cedb05f984d784dc5159)
  * WIP branches: [here](https://github.com/yurydelendik/debugger.html/tree/x-scopes) and [here](https://github.com/yurydelendik/emscripten/tree/x-scopes)

## News and Releases

* [An official subcharter of the W3C wasm WG for debugging has been created](https://github.com/WebAssembly/debugging)
* [Announcing `wasm-bindgen` 0.2.16](https://github.com/rustwasm/wasm-bindgen/blob/master/CHANGELOG.md#0216)
* [Announcing initial release of `wasm-bindgen-futures`](https://crates.io/crates/wasm-bindgen-futures)
* [Announcing `js-sys` 0.2.1](https://github.com/rustwasm/wasm-bindgen/blob/master/crates/js-sys/CHANGELOG.md#021)


## Articles, Blog Posts, and Talks

* Cleaned up, curated and added an opinionated "Tools" section into the "Tools You Should Know" [section](https://rustwasm.github.io/book/tools.html) as a part of the book.
* Added a curated and opinionated "Crates You Should Know" [section](https://rustwasm.github.io/book/crates.html) to the book
* [@ashleygwilliams](https://github.com/ashleygwilliams) gave a super awesome talk at Rust Berlin - [slides](https://rustwasm.github.io/hello-wasm-bindgen/#1)
* [Saving millions of dollars with Rust and WebAssembly](https://twitter.com/jxxf/status/1027358517462626304)
* AR paint project, built with Js + Rust/wasm at [wafflejs](https://wafflejs.com/) - [slides](https://slides.cwervo.com/wafflejs-webar-2018-08/#/)
* "Leveraging Jupyter, Rust, and WebAssembly for Browser-Based Visual Data Exploration" [video](https://www.youtube.com/watch?v=5dl_m_6T2bU) [slides](https://munkm.github.io/2018-07-13-scipy/#/) -- a talk given by [@munkm](https://github.com/munkm) at SciPy on July 13 about using rust/wasm backed modules for visualizing datasets in jupypter notebooks. 

## RFCs

* [RFC Proposal for supporting JavaScript method inheritance using Rust traits.](https://github.com/rustwasm/rfcs/pull/3) New RFC!

## Requests for Contribution

* [**Join the Rust and WebAssembly Working Group!**][get-involved]
  * [All issues labeled "good first issue" in the `rustwasm/*` repositories](https://github.com/issues?q=is%3Aopen+is%3Aissue+user%3Arustwasm+archived%3Afalse+label%3A%22good+first+issue%22)
  * [All issues labeled "help wanted" in the `rustwasm/*` repositories](https://github.com/issues?q=is%3Aopen+is%3Aissue+user%3Arustwasm+archived%3Afalse+label%3A%22help+wanted%22)
* [Expose bindings to *ALL* the global JS things](https://github.com/rustwasm/wasm-bindgen/issues/275)
* Help build the `web-sys` crate by enabling bindings generation for more WebIDL interfaces!
  * [Information on contributing to `web-sys`](https://rustwasm.github.io/wasm-bindgen/web-sys.html)
  * [Issues tracking adding various Web APIs to `web-sys`](https://github.com/rustwasm/wasm-bindgen/issues?q=is%3Aissue+is%3Aopen+label%3Aweb-sys)
* [Add extends = ... attributes to js-sys types](https://github.com/rustwasm/wasm-bindgen/issues/670)

[get-involved]: https://github.com/rustwasm/team/blob/master/README.md#get-involved
