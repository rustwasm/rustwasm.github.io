---
title:  "This Week in Rust and WebAssembly 14"
---

Hello and welcome to another issue of *This Week in Rust and WebAssembly*!

[Rust](https://rust-lang.org) is a systems language pursuing the trifecta:
safety, concurrency, and speed.

[WebAssembly](http://webassembly.org) is a stack-based virtual machine and
instruction set. It is fast, safe, portable, and part of the open Web
platform. By compiling to WebAssembly, we can run Rust code on the Web!

This is a weekly summary of Rust and WebAssembly's progress and community.

Did we miss something? Tweet to us at [@rustwasm](https://twitter.com/rustwasm)
or [send us a pull request](https://github.com/rustwasm/rustwasm.github.io).

**Want to get involved in Rust and WebAssembly? [Join the Rust and WebAssembly working group!][get-involved]**

## News and Blog Posts from Around the Web

*Want to make sure something ends up on this list next time we publish an issue?
[Leave a comment on this issue.](https://github.com/rustwasm/team/issues/79)*

* [**Fast, Bump-Allocated Virtual DOMs with Rust and
  Wasm**](https://hacks.mozilla.org/2019/03/fast-bump-allocated-virtual-doms-with-rust-and-wasm/)
* [Version 0.3 of the `seed` framework was
  released](https://github.com/David-OConnor/seed/blob/master/CHANGELOG.md#v030)
* [`web-dom` is an alternative way to access the DOM from
  Rust](https://github.com/web-dom/web-dom)
* [Ensembl 2020 (a genome browser) will use Rust and
  Wasm](https://twitter.com/ensembl/status/1106140169575514113)
* [The `actix` project is working on getting their actors running as Wasm on the
  Web](https://users.rust-lang.org/t/another-small-step-to-wasm-compatibility-actix-actors-in-the-browser/26318)
* [Demo: a real-time pitch detector Web application (and reusable library
  crate!) made with Rust and
  Wasm](https://twitter.com/alesgeno/status/1107662063168614400)
* [The Godbolt Compiler Explorer can show Wasm disassembly, with color-coded
  highlighting showing which Rust source text compiled into which Wasm
  instructions](https://rust.godbolt.org/z/PZqG56)

## Updates from [`rustwasm/*`](https://github.com/rustwasm)

### RFCs

#### New RFCs

* [Add `watch` and `serve` subcommands to
  `wasm-pack`](https://github.com/rustwasm/rfcs/pull/10)

#### Final Comment Period RFCs

None.

#### Merged RFCs

* [**2019 Roadmap 🎉**](https://github.com/rustwasm/rfcs/pull/7)
* [Enable depending on NPM packages](https://github.com/rustwasm/rfcs/pull/8)

### Working Group Meetings

* [Watch the recording of this week's working group meeting on
  YouTube](https://youtu.be/uYySHPCuLz0)
* [Come join us at next week's working group
  meeting!](https://github.com/rustwasm/team/issues/262)

### Gloo

* [Gloo is the modular toolkit we decided to collectively build in our 2019
  roadmap.](https://rustwasm.github.io/2019/03/12/lets-build-gloo-together.html)
  We've been having lots of good discussion about scope and API design in issue
  threads! (Not doing lots of PRs quite yet.)
* @OddCoincidence [added support for
  `setInterval`](https://github.com/rustwasm/gloo/pull/24) to `gloo-timers`.

### `rustwasm.github.io`

* @DebugSteven [removed some unused CSS
  rules](https://github.com/rustwasm/rustwasm.github.io/pull/43) from our
  Website's stylesheets.

### `rust-webpack-template`

* @alexcrichton [upgraded the
  template](https://github.com/rustwasm/rust-webpack-template/pull/120) to the
  Rust 2018 edition.

### Twiggy

* @data-pup [upgraded Twiggy](https://github.com/rustwasm/twiggy/pull/265) to
  the Rust 2018 edition.
* @data-pup [added more tests](https://github.com/rustwasm/twiggy/pull/268) for
  the `twiggy diff` subcommand.

### `wasm-bindgen`

* [**We released `wasm-bindgen` version 0.2.39!
  🎉**](https://github.com/rustwasm/wasm-bindgen/blob/master/CHANGELOG.md#0239)
* @c410-f3r made `wasm-bindgen`'s generated TypeScript interfaces' functions'
  argument names be [preserved from the Rust
  source](https://github.com/rustwasm/wasm-bindgen/pull/1344) instead of being
  generated symbols.
* @ibaryshnikov [cleaned up](https://github.com/rustwasm/wasm-bindgen/pull/1336)
  our Web GL example.
* @nstoddard [added immutability
  whitelisting](https://github.com/rustwasm/wasm-bindgen/pull/1333) for
  `Uint8Array`, `ArrayBufferView`, and `BufferSource`.
* @RReverser [fixed some copy-paste
  errors](https://github.com/rustwasm/wasm-bindgen/pull/1372) in documentation
  for `Int32Array` and `Uint32Array`
* @RReverser [cleaned up and de-duplicated our binding
  definitions](https://github.com/rustwasm/wasm-bindgen/pull/1371) to the
  different kinds of typed arrays!
* @c410-f3r [expanded the
  testing](https://github.com/rustwasm/wasm-bindgen/pull/1356) of our emitted
  TypeScript interface definitions.
* @alexcrichton [added the `#[wasm_bindgen(raw_module = "...")]`
  attribute](https://github.com/rustwasm/wasm-bindgen/pull/1353) to the
  `wasm-bindgen` proc-macro.
* @konradsz [fixed the number-slices example's JS
  imports.](https://github.com/rustwasm/wasm-bindgen/pull/1351)
* @alexlapa [enabled passing optional imported
  `enum`s](https://github.com/rustwasm/wasm-bindgen/pull/1350) over the FFI
  boundary.

### `wasm-pack`

* [**We released `wasm-pack` version 0.7.0!
  🎉**](https://github.com/rustwasm/wasm-pack/blob/master/CHANGELOG.md#%EF%B8%8F-070)
* @alexcrichton [added support for the `web`
  target](https://github.com/rustwasm/wasm-pack/pull/567) to `wasm-pack`. This
  target uses browsers' native support for ES modules, and doesn't require the
  use of a JS bundler.
* @alexcrichton [started migrating `wasm-pack`'s CLI
  output](https://github.com/rustwasm/wasm-pack/pull/547) towards our 1.0 vision
  for `wasm-pack` output. Notably, `cargo build`'s colors and progress bar
  should work now.
* @alexcrichton [added a
  smorgasbord](https://github.com/rustwasm/wasm-pack/pull/590) of docs
  improvements.
* @drager [added support for non-`rustup`-based Rust development
  environments](https://github.com/rustwasm/wasm-pack/pull/552) to `wasm-pack`.
* @ashleygwilliams [added a quickstart doc
  page](https://github.com/rustwasm/wasm-pack/pull/576) for using `wasm-pack`
  with Webpack.

### `wasm-pack-template`

* @alexcrichton [upgraded the
  template](https://github.com/rustwasm/wasm-pack-template/pull/37) to the Rust
  2018 edition.

## Requests for Contribution

**Want to get involved in Rust and WebAssembly? [Join the Rust and WebAssembly
working group!][get-involved]**

* [**Let's Build Gloo
  Together**](https://rustwasm.github.io/2019/03/12/lets-build-gloo-together.html)
* [All issues labeled "good first issue" in the `rustwasm/*`
  repositories](https://github.com/issues?q=is%3Aopen+is%3Aissue+user%3Arustwasm+archived%3Afalse+label%3A%22good+first+issue%22)
* [All issues labeled "help wanted" in the `rustwasm/*`
  repositories](https://github.com/issues?q=is%3Aopen+is%3Aissue+user%3Arustwasm+archived%3Afalse+label%3A%22help+wanted%22)

[get-involved]: https://github.com/rustwasm/team/blob/master/README.md#get-involved

### New Good First Issues

* [Gloo: Make the timers crate follow submodule
  design](https://github.com/rustwasm/gloo/issues/36)
