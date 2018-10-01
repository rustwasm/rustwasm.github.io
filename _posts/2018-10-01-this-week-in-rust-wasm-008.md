---
title:  "This Week in Rust and WebAssembly 008"
---

Hello and welcome to another issue of *This Week in Rust and WebAssembly*!

[Rust](https://rust-lang.org) is a systems language pursuing the trifecta: safety, concurrency, and speed.

[WebAssembly](http://webassembly.org) is a stack-based virtual machine and instruction set. It is fast, safe, portable, and part of the open Web platform. By compiling to WebAssembly, we can run Rust code on the Web!

This is a weekly summary of Rust and WebAssembly's progress and community.

Did we miss something? Tweet to us at [@rustwasm](https://twitter.com/rustwasm) or [send us a pull request](https://github.com/rustwasm/rustwasm.github.io).

**Want to get involved in Rust and WebAssembly? [Join the Rust and WebAssembly working group!][get-involved]**

## News and Blog Posts

*Want to make sure something ends up on this list next time we publish an issue?
[Leave a comment on this issue.](https://github.com/rustwasm/team/issues/79)*

* [**The Biggest `wasm-pack` Release Yet**](https://rustwasm.github.io/2018/09/24/the-biggest-wasm-pack-release-yet.html)
* [**Announcing the `web-sys` crate!**](https://rustwasm.github.io/2018/09/26/announcing-web-sys.html)
* [Programming WebAssembly with Rust — The Book!!](https://medium.com/@KevinHoffman/programming-webassembly-with-rust-the-book-7c4a890fcf97) Kevin Hoffman is writing a book on Rust and Wasm for the Pragmatic Programmers book publisher.
* [Rust and WebAssembly with Nick Fitzgerald.](http://fitzgeraldnick.com/2018/10/01/sfhtml5-rust-and-wasm-talk.html) Video recording and slides from the most recent SFHTML5 meetup that was all about Wasm.
* [Format rust code in the browser with `rustfmt` compiled to wasm!](https://alexcrichton.github.io/rustfmt-wasm/)
* [Olin is a server-side WebAssembly platform](https://olin-http-example.herokuapp.com/)
* [The P64Lang parser and interpreter running as a wasm module](https://www.polaris64.net/resources/programming/p64lang_wasm/)
* [How `wasm-bindgen` Facilitates Interop Between Rust and JavaScript](https://blog.ryanlevick.com/posts/wasm-bindgen-interop/)
* [@sendilkumarn](https://twitter.com/sendilkumarn) will be giving a talk titled "Do things blazingly fast with WebAssembly" at [Voxxed Days Ticino 2018](https://cfpvdt18.confinabox.com/talk/XAU-2186/Do_things_blazingly_fast_with_WebAssembly)
* [Isomorphic Desktop Apps with Rust (Electron and Wasm)](https://speice.io/2018/09/isomorphic-apps.html)
* [Smithy progress update: how I decreased WebAssembly bundle size by 90%](https://medium.com/@robert.balicki_2494/smithy-progress-update-how-i-decreased-webassembly-bundle-size-by-90-e7fe194b2f58)

## Updates from [`rustwasm/*`](https://github.com/rustwasm)

* [Released `wasm-pack` 0.5.0](https://github.com/rustwasm/wasm-pack/blob/master/CHANGELOG.md#%EF%B8%8F-050)
* [Released `wasm-bindgen` 0.2.23](https://github.com/rustwasm/wasm-bindgen/blob/master/CHANGELOG.md#0223)
* [Released `js-sys` 0.3.0](https://crates.io/crates/js-sys)
* [Released `web-sys` 0.3.0](https://crates.io/crates/web-sys)
* Added new sections to `wasm-bindgen` guide:
  * [Writing tests for Rust and WebAssembly programs using `wasm-bindgen-test`](https://rustwasm.github.io/wasm-bindgen/wasm-bindgen-test/index.html)
  * [Working with untyped JS values in the `wasm-bindgen`](https://rustwasm.github.io/wasm-bindgen/reference/accessing-properties-of-untyped-js-values.html)
  * [`web-sys`](https://rustwasm.github.io/wasm-bindgen/web-sys/index.html)

## Requests for Contribution

* [**Join the Rust and WebAssembly Working Group!**][get-involved]
  * [All issues labeled "good first issue" in the `rustwasm/*` repositories](https://github.com/issues?q=is%3Aopen+is%3Aissue+user%3Arustwasm+archived%3Afalse+label%3A%22good+first+issue%22)
  * [All issues labeled "help wanted" in the `rustwasm/*` repositories](https://github.com/issues?q=is%3Aopen+is%3Aissue+user%3Arustwasm+archived%3Afalse+label%3A%22help+wanted%22)

[get-involved]: https://github.com/rustwasm/team/blob/master/README.md#get-involved
