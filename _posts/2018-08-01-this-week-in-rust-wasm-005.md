---
title:  "This Week in Rust and WebAssembly 005"
---

Hello and welcome to another issue of *This Week in Rust and WebAssembly*!

[Rust](https://rust-lang.org) is a systems language pursuing the trifecta: safety, concurrency, and speed.

[WebAssembly](http://webassembly.org) is a stack-based virtual machine and instruction set. It is fast, safe, portable, and part of the open Web platform. By compiling to WebAssembly, we can run Rust code on the Web!

This is a weekly summary of Rust and WebAssembly's progress and community.

Did we miss something? Tweet to us at [@rustwasm](https://twitter.com/rustwasm) or [send us a pull request](https://github.com/rustwasm/rustwasm.github.io).

**Want to get involved in Rust and WebAssembly? [Join the Rust and WebAssembly working group!][get-involved]**

## New Tools, Crates, and Projects

* [Percy](https://github.com/chinedufn/percy) A modular toolkit for building isomorphic web apps with Rust + WebAssembly
* [CBOR playground built with wasm-bindgen](http://cbor.nemo157.com/?type=diag&value=%5B1%2C+2%2C+3%2C+%5B4%2C+5%2C+%5B6%5D%2C+%5B7%5D%5D%2C+%28_+%22hello%22%2C+%22rust%22%2C+%22%F0%9F%91%8B%22%29%5D)

## News and Releases

* [Announcing `js-sys`](https://rustwasm.github.io/2018/07/26/announcing-the-js-sys-crate.html)- [crate](https://crates.io/crates/js-sys)
* [Announcing `wasm-pack` 0.4.2!](https://github.com/rustwasm/wasm-pack/blob/master/CHANGELOG.md#-042)
* [Announcing `wee_alloc` 0.4.2!](https://github.com/rustwasm/wee_alloc/blob/master/CHANGELOG.md#042)
* [Announcing `wasm-bindgen` 0.2.15](https://github.com/rustwasm/wasm-bindgen/blob/master/CHANGELOG.md#0215)

## Articles, Blog Posts, and Talks

* [Is WebAssembly the return of Java Applets & Flash?](https://words.steveklabnik.com/is-webassembly-the-return-of-java-applets-flash)
* [Writing a front-end WebAssembly framework in Rust: lessons learned](https://medium.com/@robert.balicki_2494/writing-a-front-end-webassembly-framework-in-rust-lessons-learned-7cc48ed27d96)

## Requests for Contribution

* [**Join the Rust and WebAssembly Working Group!**][get-involved]
  * [All issues labeled "good first issue" in the `rustwasm/*` repositories](https://github.com/issues?q=is%3Aopen+is%3Aissue+user%3Arustwasm+archived%3Afalse+label%3A%22good+first+issue%22)
  * [All issues labeled "help wanted" in the `rustwasm/*` repositories](https://github.com/issues?q=is%3Aopen+is%3Aissue+user%3Arustwasm+archived%3Afalse+label%3A%22help+wanted%22)
* [Expose bindings to *ALL* the global JS things](https://github.com/rustwasm/wasm-bindgen/issues/275)
* Help build the `web-sys` crate by enabling bindings generation for more WebIDL interfaces!
  * [Information on contributing to `web-sys`](https://rustwasm.github.io/wasm-bindgen/web-sys.html)
  * [Issues tracking adding various Web APIs to `web-sys`](https://github.com/rustwasm/wasm-bindgen/issues?q=is%3Aissue+is%3Aopen+label%3Aweb-sys)
* [Help migrate the `wasm_bindgen` crate's tests to `wasm_bindgen_test`](https://github.com/rustwasm/wasm-bindgen/issues/603)

[get-involved]: https://github.com/rustwasm/team/blob/master/README.md#get-involved
