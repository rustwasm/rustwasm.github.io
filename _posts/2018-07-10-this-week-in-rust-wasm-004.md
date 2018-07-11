---
title:  "This Week in Rust and WebAssembly 004"
---

Hello and welcome to another issue of *This Week in Rust and WebAssembly*!

[Rust](https://rust-lang.org) is a systems language pursuing the trifecta: safety, concurrency, and speed.

[WebAssembly](http://webassembly.org) is a stack-based virtual machine and instruction set. It is fast, safe, portable, and part of the open Web platform. By compiling to WebAssembly, we can run Rust code on the Web!

This is a weekly summary of Rust and WebAssembly's progress and community.

Did we miss something? Tweet to us at [@rustwasm](https://twitter.com/rustwasm) or [send us a pull request](https://github.com/rustwasm/rustwasm.github.io).

**Want to get involved in Rust and WebAssembly? [Join the Rust and WebAssembly working group!][get-involved]**

## New Tools, Crates, and Projects

* [Project Ice Puzzle](http://www.matthewmichelotti.com/games/project_ice_puzzle/) is a game made with Rust and WebAssembly.
* [wasmbooth](https://mtharrison.github.io/wasmbooth/) is a video effect booth written in Rust and WebAssembly.
* [wasmparse-{core,bridge,web}](https://github.com/mtharrison/wasmparse-core) is a browser-based interactive Wasm  disassembler (in-progress). Its goal is to teach people about the webassembly format, webassembly code and how the stack machine works. The cool thing is it is also be written in Rust and compiled to wasm. Wasm all the way down!
* [Try `nphysics3d` demos in your desktop browser!](https://www.reddit.com/r/rust/comments/8pvgpb/try_nphysics3d_demos_on_your_desktop_browser/)

## News and Releases

* [Announcing `wasm-pack` 0.4.0!](https://github.com/rustwasm/wasm-pack/blob/master/CHANGELOG.md#-040)
* [Announcing Twiggy 0.2.0!](https://users.rust-lang.org/t/announcing-twiggy-version-0-2-0/18312)
* [Announcing `wee_alloc` 0.4.1!](https://github.com/rustwasm/wee_alloc/blob/master/CHANGELOG.md#041)
* [JPEG decoding via the image crate now works on wasm and asm.js](https://github.com/kaksmet/jpeg-decoder/issues/87)

## Articles, Blog Posts, and Talks

* [**Our Vision for Rust and WebAssembly**](https://rustwasm.github.io/2018/06/25/vision-for-rust-and-wasm.html)
* [**Our Vision for `wasm-bindgen`**](https://rustwasm.github.io/2018/07/02/vision-for-wasm-bindgen.html)
* [Making calls to WebAssembly fast and implementing `anyref` in Firefox](https://blog.benj.me/2018/07/04/mozilla-2018-faster-calls-and-anyref/)
* [Why we believe in Wasm as the base layer of decentralised application development](https://paritytech.io/wasm-smart-contract-development/)
* [Building better compression together with DivANS.](https://blogs.dropbox.com/tech/2018/06/building-better-compression-together-with-divans/) DivANS is a new concurrent, vectorized compression algorithm in Rust, compiled to WASM for high density compression in the browser and on servers.
* Video: [Learn+Try: Rust in the Browser via WebAssembly @ Rust DC, April 12, 2018](https://www.youtube.com/watch?v=btCgzXgmhys)

## RFCs

* [Propose an RFC process based on Rust's but lighter weight.](https://github.com/rustwasm/rfcs/pull/1) This is entering its final comment period!

## Requests for Contribution

* [**Join the Rust and WebAssembly Working Group!**][get-involved]
  * [All issues labeled "good first issue" in the `rustwasm/*` repositories](https://github.com/issues?q=is%3Aopen+is%3Aissue+user%3Arustwasm+archived%3Afalse+label%3A%22good+first+issue%22)
  * [All issues labeled "help wanted" in the `rustwasm/*` repositories](https://github.com/issues?q=is%3Aopen+is%3Aissue+user%3Arustwasm+archived%3Afalse+label%3A%22help+wanted%22)
* [Expose bindings to *ALL* the global JS things](https://github.com/rustwasm/wasm-bindgen/issues/275)
* Help build the `web-sys` crate by enabling bindings generation for more WebIDL interfaces!
  * [Information on contributing to `web-sys`](https://rustwasm.github.io/wasm-bindgen/web-sys.html)
  * [Issues tracking adding various Web APIs to `web-sys`](https://github.com/rustwasm/wasm-bindgen/issues?q=is%3Aissue+is%3Aopen+label%3Aweb-sys)

[get-involved]: https://github.com/rustwasm/team/blob/master/README.md#get-involved
