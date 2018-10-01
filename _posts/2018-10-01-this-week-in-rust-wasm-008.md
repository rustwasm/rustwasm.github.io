---
title:  "This Week in Rust and WebAssembly 008"
---

Hello and welcome to another issue of *This Week in Rust and WebAssembly*!

[Rust](https://rust-lang.org) is a systems language pursuing the trifecta: safety, concurrency, and speed.

[WebAssembly](http://webassembly.org) is a stack-based virtual machine and instruction set. It is fast, safe, portable, and part of the open Web platform. By compiling to WebAssembly, we can run Rust code on the Web!

This is a weekly summary of Rust and WebAssembly's progress and community.

Did we miss something? Tweet to us at [@rustwasm](https://twitter.com/rustwasm) or [send us a pull request](https://github.com/rustwasm/rustwasm.github.io).

**Want to get involved in Rust and WebAssembly? [Join the Rust and WebAssembly working group!][get-involved]**

## New Tools, Crates, and Projects

* [Format rust code in the browser with `rustfmt` compiled to wasm! ](https://alexcrichton.github.io/rustfmt-wasm/)
* [Olin is a server-side WebAssembly platform](https://olin-http-example.herokuapp.com/)
* [The P64Lang parser and interpreter running as a wasm module](https://www.polaris64.net/resources/programming/p64lang_wasm/)

## News and Releases

* [Mario pixel art using `web-sys` and `js-sys` crates in wasm-bindgen](https://twitter.com/T5uku5hi/status/1037730970609307648)
* [Announcing `wasm-pack` 0.5.0](https://github.com/rustwasm/wasm-pack/blob/master/CHANGELOG.md#%EF%B8%8F-050)
* [Announcing `wasm-bindgen` 0.2.23](https://github.com/rustwasm/wasm-bindgen/blob/master/CHANGELOG.md#0223)
* [Announcing `js-sys` 0.3.0](https://crates.io/crates/js-sys)
* [Announcing `web-sys` 0.3.0](https://crates.io/crates/web-sys)

## Articles, Blog Posts, and Talks

* Added new sections to `wasm-bindgen` guide
  * [Writing tests for Rust and WebAssembly programs using `wasm-bindgen-test`](https://rustwasm.github.io/wasm-bindgen/wasm-bindgen-test/index.html)
  * [Working with untyped JS values in the `wasm-bindgen`](https://rustwasm.github.io/wasm-bindgen/reference/accessing-properties-of-untyped-js-values.html)
  * [`web-sys`](https://rustwasm.github.io/wasm-bindgen/web-sys/index.html)
* [How Wasm-Bindgen Facilitates Interop Between Rust and Javascript](https://blog.ryanlevick.com/posts/wasm-bindgen-interop/)
* [@sendilkumarn](https://twitter.com/sendilkumarn) is giving a talk on `Do things blazingly fast with WebAssembly` at [Voxxed Days Ticino 2018](https://cfpvdt18.confinabox.com/talk/XAU-2186/Do_things_blazingly_fast_with_WebAssembly)

## Requests for Contribution

* [**Join the Rust and WebAssembly Working Group!**][get-involved]
  * [All issues labeled "good first issue" in the `rustwasm/*` repositories](https://github.com/issues?q=is%3Aopen+is%3Aissue+user%3Arustwasm+archived%3Afalse+label%3A%22good+first+issue%22)
  * [All issues labeled "help wanted" in the `rustwasm/*` repositories](https://github.com/issues?q=is%3Aopen+is%3Aissue+user%3Arustwasm+archived%3Afalse+label%3A%22help+wanted%22)* [Expose bindings to *ALL* the global JS things](https://github.com/rustwasm/wasm-bindgen/issues/275)
* Help build the `web-sys` crate by enabling bindings generation for more WebIDL interfaces!
  * [Information on contributing to `web-sys`](https://rustwasm.github.io/wasm-bindgen/web-sys.html)
  * [Issues tracking adding various Web APIs to `web-sys`](https://github.com/rustwasm/wasm-bindgen/issues?q=is%3Aissue+is%3Aopen+label%3Aweb-sys)

[get-involved]: https://github.com/rustwasm/team/blob/master/README.md#get-involved
