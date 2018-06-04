---
layout: post
title:  "This Week in Rust and WebAssembly 003"
date:   2018-06-04 13:20:31 +0200
---

Hello and welcome to another issue of *This Week in Rust and WebAssembly*!

[Rust](https://rust-lang.org) is a systems language pursuing the trifecta: safety, concurrency, and speed.

[WebAssembly](http://webassembly.org) is a stack-based virtual machine and instruction set. It is fast, safe, portable, and part of the open Web platform. By compiling to WebAssembly, we can run Rust code on the Web!

This is a weekly summary of Rust and WebAssembly's progress and community.

Did we miss something? Tweet to us at [@rustwasm](https://twitter.com/rustwasm) or [send us a pull request](https://github.com/rustwasm/rustwasm.github.io).

**Want to get involved in Rust and WebAssembly? [Join the Rust and WebAssembly working group!][get-involved]**

[get-involved]: https://github.com/rust-lang-nursery/rust-wasm/blob/master/README.md#get-involved

## New Tools, Crates, and Projects
* [rust_wasm_template](https://github.com/rustwasm/rust_wasm_template)
    - This is a template to jump-start your Rust and WebAssembly project and let you hit the ground running.
* [console_error_panic_hook](https://github.com/rustwasm/console_error_panic_hook)
    - Debug panics on wasm32-unknown-unknown easier.
* [Snowhash](https://joshleeb.com/posts/rust-wasm-snowhash/)
    - Generates unique ❄️ for your hash.


## News and Releases
* [wasmi port that works on Intel SGX](https://twitter.com/mgattozzi/status/1000370042331070466)
* [Logobble, a site that shows interesting things about Rust CI. Built with D3.js & Rust-WebAssembly](https://aidanhs.com/logobble/)
* [cat(1) implemented on WebAssembly + Cervus](https://www.reddit.com/r/rust/comments/8mhddt/cat1_implemented_on_webassembly_cervus/)
* [nalgebra gained support for wasm32-unknown-unknown](http://nalgebra.org/wasm_and_embedded_programming/)
* [wasm-pack  0.3.0 released](https://twitter.com/ag_dubs/status/1002185432581492736)


## Articles, Blog Posts, and Talks
* [New Rustacean podcast: Crates you should know: The wasm tools.](https://newrustacean.com/show_notes/cysk/wasm/index.html)
* [Webpack and WebAssembly](https://speakerdeck.com/sendilkumarn/webpack-and-webassembly) by sendilkumarn(https://twitter.com/sendilkumarn) 

## Requests for Contribution
* Request for contributors
    - [adding wasm-bindgen support to rand](https://www.reddit.com/r/rust/comments/8msrfp/help_add_wasmbindgen_support_to_rand/)
