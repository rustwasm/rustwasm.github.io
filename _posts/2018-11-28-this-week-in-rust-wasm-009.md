---
title:  "This Week in Rust and WebAssembly 009"
---

Hello and welcome to another issue of *This Week in Rust and WebAssembly*!

[Rust](https://rust-lang.org) is a systems language pursuing the trifecta: safety, concurrency, and speed.

[WebAssembly](http://webassembly.org) is a stack-based virtual machine and instruction set. It is fast, safe, portable, and part of the open Web platform. By compiling to WebAssembly, we can run Rust code on the Web!

This is a weekly summary of Rust and WebAssembly's progress and community.

Did we miss something? Tweet to us at [@rustwasm](https://twitter.com/rustwasm) or [send us a pull request](https://github.com/rustwasm/rustwasm.github.io).

**Want to get involved in Rust and WebAssembly? [Join the Rust and WebAssembly working group!][get-involved]**

<!-- TODO: check recent r/rust and users.rust-lang.org posts for "wasm" and "webassembly: -->
<!-- https://github.com/rustwasm/team/issues/79 -->
<!-- https://www.reddit.com/r/rust/search?q=wasm&sort=relevance&restrict_sr=on&t=month -->
<!-- https://www.reddit.com/r/rust/search?q=webassembly&restrict_sr=on&sort=relevance&t=month -->
<!-- https://users.rust-lang.org/search?q=wasm%20after%3A2018-06-01 -->
<!-- https://users.rust-lang.org/search?q=webassembly%20after%3A2018-06-01 -->

## News and Blog Posts

*Want to make sure something ends up in this list on the next This Week in Rust and WebAssembly?
[Leave a comment on this issue.](https://github.com/rustwasm/team/issues/79)*

* **[Multithreading Rust and WebAssembly](https://rustwasm.github.io/2018/10/24/multithreading-rust-and-wasm.html)**
* [Introducing the Ruukh Framework.](https://sharadchand.com/2018/10/03/ruukh-framework.html) An experimental next-gen frontend framework for the Web in Rust. [GitHub repository.](https://github.com/csharad/ruukh/)
* The new website for the `pest` PEG parser generator has a nice wasm-based try-it-live demo at the bottom: https://pest.rs/
* [WebAssembly and Dynamic Memory.](https://frehberg.wordpress.com/webassembly-and-dynamic-memory/) A comparison of portability of allocators for wasm, featuring `wee_alloc`.
* [Simi](https://crates.io/crates/simi) is a new, simple framework for building wasm-front-end Web application in Rust.
* [Encrusted](https://sterlingdemille.com/encrusted/) is an interpreter for Infocom-era interactive fiction games like Zork that runs in your browser and is built with Rust and WebAssembly.
* [Using WebAssembly with Rust](https://egghead.io/courses/using-webassembly-with-rust) is a new, free Video Course on Egghead.
* [`Pauan/SaltyBetBot`](https://github.com/Pauan/SaltyBetBot) is a SaltyBet Bot written entirely in Rust and `stdweb` and compiled to Wasm.
* [Serverless Rust with AWS Lambda and WebAssembly](https://blog.scottlogic.com/2018/10/18/serverless-rust.html)
* [Serverless Rust with Cloudflare Workers and WebAssembly](https://blog.cloudflare.com/cloudflare-workers-as-a-serverless-rust-platform/)
* [`php-ext-wasm`](https://github.com/Hywan/php-ext-wasm) is a PHP extension written in C, calling a Rust lib through FFI, using `wasmi` behind the scene.
* [HOWTO: Setting up WebAssembly on stable Rust without rustup.](https://www.reddit.com/r/rust/comments/9t95fd/howto_setting_up_webassembly_on_stable_rust/) Instructions on using raw Rust and Wasm if you happen not to have `rustup` available.
* [Wasmer](https://github.com/wasmerio/wasmer) is a WebAssembly runtime built on top of Cranelift.
* [Terrarium](https://wasm.fastlylabs.com/) is a fork of [WebAssembly Studio](https://webassembly.studio/), except rather than run WebAssembly in your browser, it is deployed to a fastly server.
* [`runwasm`](https://github.com/Vurich/runwasm) is an Emscripten emulation layer built with `wasmi`.
* [Bringing Elm's architecture to Rust and Webassembly](https://sindrejohansen.no/blog/willow/rust/elm/2018/11/16/willow-elm-in-rust.html)
* [Stanford's CS 242 Programming Languages Class](https://cs242.stanford.edu/) will feature Rust and WebAssembly.
* [The "Programming WebAssembly with Rust" book](https://pragprog.com/book/khrust/programming-webassembly-with-rust) by Kevin Hoffman and published by Pragmatic Programmers is in beta and available for pre-order.
* [`yiransheng/rust-snake-wasm`](https://github.com/yiransheng/rust-snake-wasm) is a snake game in Rust and WebAssembly.
* [`console-web`](https://crates.io/crates/console-web) is a crate for writing to the console in wasm using `wasm-bindgen`.

## Updates from [`rustwasm/*`](https://github.com/rustwasm)

* [`wasm-bindgen` 0.2.28 released! 🎉](https://github.com/rustwasm/wasm-bindgen/blob/master/CHANGELOG.md#0228)
* [`wasm-pack` 0.5.1 released! 🎉](https://github.com/rustwasm/wasm-pack/blob/master/CHANGELOG.md#-051)
* [Twiggy 0.3.0 released! 🎉](https://github.com/rustwasm/twiggy/blob/master/CHANGELOG.md#030)
* There are two new reference sections in the Rust and Wasm book:
  1. [Which Crates Will Work with Rust and WebAssembly?](https://rustwasm.github.io/book/reference/which-crates-work-with-wasm.html)
  2. [How to Add WebAssembly Support to a General-Purpose Crate](https://rustwasm.github.io/book/reference/add-wasm-support-to-crate.html)

## Requests for Contribution

* [**Join the Rust and WebAssembly Working Group!**][get-involved]
  * [All issues labeled "good first issue" in the `rustwasm/*` repositories](https://github.com/issues?q=is%3Aopen+is%3Aissue+user%3Arustwasm+archived%3Afalse+label%3A%22good+first+issue%22)
  * [All issues labeled "help wanted" in the `rustwasm/*` repositories](https://github.com/issues?q=is%3Aopen+is%3Aissue+user%3Arustwasm+archived%3Afalse+label%3A%22help+wanted%22)

[get-involved]: https://github.com/rustwasm/team/blob/master/README.md#get-involved

## Jobs

* [Fastly is hiring](https://www.fastly.com/about/jobs/apply?gh_jid=1320541) for work on their native WebAssembly compiler, which is written in Rust, based on [Cranelift](https://github.com/CraneStation/cranelift)

<!-- ## `rustwasm` Projects Activity -->

<!-- Recently merged pull requests to projects in the [`rustwasm` GitHub -->
<!-- organization][rustwasm-org]: -->

<!-- [rustwasm-org]: https://github.com/rustwasm -->

<!-- TODO: insert the output of `pulls_since -o rustwasm -s dd.mm.yyyy` here, where -->
<!-- "dd.mm.yyyy" is the date the *last* newsletter was published. See -->
<!-- https://github.com/budziq/pulls_since or run `cargo install pulls_since`. -->
