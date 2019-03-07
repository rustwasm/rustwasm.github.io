---
title:  "This Week in Rust and WebAssembly 13"
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

<!-- TODO: check recent r/rust and users.rust-lang.org posts for "wasm" and "webassembly": -->
<!-- https://twitter.com/rustwasm -->

## News and Blog Posts from Around the Web

*Want to make sure something ends up on this list next time we publish an issue?
[Leave a comment on this issue.](https://github.com/rustwasm/team/issues/79)*

* [Up and Running with React, Rust, and
  Wasm](https://prestonrichey.com/blog/react-rust-wasm/)
* The Tao of Rust is a book about Rust that was originally published in
  China. It has a WebAssembly section, and is [getting translated into
  English](https://www.reddit.com/r/rust/comments/ax86y1/introducing_the_book_the_tao_of_rust/)!
* [Tweek is a new tween animation kit for Rust that supports
  Wasm](https://github.com/wasm-network/tweek-rust)

## Updates from [`rustwasm/*`](https://github.com/rustwasm)

### RFCs

#### New RFCs

* [Amend the RFC process](https://github.com/rustwasm/rfcs/pull/9)

#### Final Comment Period RFCs

None.

#### Merged RFCs

* [Add support for local JavaScript snippets to `wasm-bindgen`](https://github.com/rustwasm/rfcs/pull/6)

### Working Group Meetings

* [Watch the recording of this week's working group meeting on
  YouTube](https://youtu.be/sQE6IjnzwS8)
* [Come join us at next week's working group
  meeting!](https://github.com/rustwasm/team/issues/260)

### `rustwasm.github.io`

* @DebugSteven and @alexcrichton [aggregated the Rust and WebAssembly book, the
  `wasm-bindgen` guide, and the `wasm-pack` guide into a single
  bookshelf](https://github.com/rustwasm/rustwasm.github.io/pull/41), where all
  of our docs can be found in one place!

### `twiggy`

* @data-pup [added `rustfmt` and `clippy`
  integration](https://github.com/rustwasm/twiggy/pull/253) into Twiggy's CI
  setup.
* @sepiropht [improved Twiggy's
  detection](https://github.com/rustwasm/twiggy/pull/260) of what kind of binary
  it is looking at when there is no file extension.

### `walrus`

* @data-pup [fixed the wasm round-tripping
  tests](https://github.com/rustwasm/walrus/pull/64) for the latest release of
  the `webassembly/wabt` tools.
* @alexcrichton [added support](https://github.com/rustwasm/walrus/pull/66) for
  the WebAssembly SIMD proposal to `walrus`.

### `wasm-bindgen`

* @fitzgen [added support for `FnOnce`
  functions](https://github.com/rustwasm/wasm-bindgen/pull/1281) to
  `wasm_bindgen::Closure`.
* @c410-f3r [fixed `wasm-bindgen`
  compilation](https://github.com/rustwasm/wasm-bindgen/pull/1331) when the
  `"extra-traits"` feature was enabled.
* @alexcrichton [implemented the local JavaScript snippets
  RFC](https://github.com/rustwasm/wasm-bindgen/pull/1295) for `wasm-bindgen`.
* @Vlad-Scherbina [fixed a
  bug](https://github.com/rustwasm/wasm-bindgen/pull/1330) where if the
  directory specified by `--out-dir` does not exist, then running the
  `wasm-bindgen` CLI would fail.
* @alexcrichton [added
  testing](https://github.com/rustwasm/wasm-bindgen/pull/1314) of
  `wasm-bindgen`'s generated TypeScript interface definition files in CI.

### `wasm-pack`

* @drager [wrote a test suite](https://github.com/rustwasm/wasm-pack/pull/517)
  for `wasm-pack`'s binary installation utility crate.

## Requests for Contribution

**Want to get involved in Rust and WebAssembly? [Join the Rust and WebAssembly
working group!][get-involved]**

* [All issues labeled "good first issue" in the `rustwasm/*` repositories](https://github.com/issues?q=is%3Aopen+is%3Aissue+user%3Arustwasm+archived%3Afalse+label%3A%22good+first+issue%22)
* [All issues labeled "help wanted" in the `rustwasm/*` repositories](https://github.com/issues?q=is%3Aopen+is%3Aissue+user%3Arustwasm+archived%3Afalse+label%3A%22help+wanted%22)

[get-involved]: https://github.com/rustwasm/team/blob/master/README.md#get-involved
