---
title:  "This Week in Rust and WebAssembly 12"
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

* [Replacing a hot path in your app's JavaScript with
  WebAssembly.](https://developers.google.com/web/updates/2019/02/hotpath-with-wasm)
  The article compares versions written in Rust, C/C++, and AssemblyScript.
* [Was (not Wasm)](https://github.com/jedisct1/was-not-wasm) is a hostile
  allocator for AssemblyScript that is written in Rust.
* Wasmer has [improved their startup time by
  100x](https://medium.com/wasmer/running-webassembly-100x-faster-%EF%B8%8F-a8237e9a372d).
* [WebAssembly Troubles part 4: Microwasm.](http://troubles.md/posts/microwasm/)
  The culmination of a series of posts about issues the author has with
  WebAssembly, along with proposals for how to fix them.

## Updates from [`rustwasm/*`](https://github.com/rustwasm)

### RFCs

#### New RFCs

None.

#### Final Comment Period RFCs

* [Add support for local JavaScript snippets in
  `wasm-bindgen`](https://github.com/rustwasm/rfcs/pull/6)

#### Merged RFCs

None.

### Working Group Meetings

* [Watch the recording of this week's working group meeting on
  YouTube](https://www.youtube.com/watch?v=3YjN69U6ySE)
* [Come join us at next week's working group
  meeting!](https://github.com/rustwasm/team/issues/258)

### `rustwasm/rust-parcel-template`

* @tock203 [fixed a
  `ReferenceError`](https://github.com/rustwasm/rust-parcel-template/pull/22) in
  the template's initialization code.

### `rustwasm/twiggy`

* @data-pup [set up
  `rustfmt`-checking](https://github.com/rustwasm/twiggy/pull/253) for our
  continuous integration.
* @alexcrichton [made Twiggy account for header and section size
  bytes](https://github.com/rustwasm/twiggy/pull/250) of a Wasm binary, so
  Twiggy's output should sum to 100% now instead of just short of that.
* @philipc [updated Twiggy to version 0.17.0 of
  `gimli`](https://github.com/rustwasm/twiggy/pull/247), the crate it uses to
  parse DWARF debugging information.
* @alexcrichton [switched Twiggy over to using the `wasmparser`
  crate](https://github.com/rustwasm/twiggy/pull/245) to parse Wasm binaries,
  which gives more precise byte offset and size information, and is faster than
  the old Wasm parser.
* @data-pup [added an unreachable items
  summary](https://github.com/rustwasm/twiggy/pull/244) to the `twiggy
  dominators` output, so that all top-level rows' sizes will sum to 100%.

### `rustwasm/wasm-bindgen`

* @tyleranton added support for [emitting doc
  comments](https://github.com/rustwasm/wasm-bindgen/pull/1302) in the
  TypeScript interface definition files that `wasm-bindgen` creates.
* @LegNeato [fixed the `wasm-bindgen-test` headless browser test
  runner](https://github.com/rustwasm/wasm-bindgen/pull/1298) on macOS High
  Sierra.
* @alexcrichton [updated the `wasm-bindgen`
  guide](https://github.com/rustwasm/wasm-bindgen/pull/1285) and added a
  "Deployment" section.
* @alexcrichton [added support for the new `TextEncoder.prototype.encodeInto`
  method](https://github.com/rustwasm/wasm-bindgen/pull/1279) to
  `wasm-bindgen`'s generated JS glue when passing strings between wasm and JS.

### `rustwasm/wasm-pack`

* @ashleygwilliams [removed unnecessary
  entries](https://github.com/rustwasm/wasm-pack/pull/556) from the `"files"`
  key in `wasm-pack`'s generated `package.json`.
* @ashleygwilliams [fixed the [wasm-pack] installer on
  windows](https://github.com/rustwasm/wasm-pack/pull/550) when it is downloaded
  multiple times and ends up with a `(1)` suffix in its filename.
* @surma [wrote some docs on the `wee_alloc`
  integration](https://github.com/rustwasm/wasm-pack/pull/542) for the
  `wasm-pack` template.
* @DebugSteven [wrote a series of get-started-in-X-environment
  tutorials](https://github.com/rustwasm/wasm-pack/pull/536) for `wasm-pack`.

## Requests for Contribution

**Want to get involved in Rust and WebAssembly? [Join the Rust and WebAssembly
working group!][get-involved]**

* [All issues labeled "good first issue" in the `rustwasm/*` repositories](https://github.com/issues?q=is%3Aopen+is%3Aissue+user%3Arustwasm+archived%3Afalse+label%3A%22good+first+issue%22)
* [All issues labeled "help wanted" in the `rustwasm/*` repositories](https://github.com/issues?q=is%3Aopen+is%3Aissue+user%3Arustwasm+archived%3Afalse+label%3A%22help+wanted%22)

[get-involved]: https://github.com/rustwasm/team/blob/master/README.md#get-involved

### New Good First Issues

* [`wasm-bindgen`: Add `#[wasm_bindgen(ignore)]` to ignore a `pub` field and not
  generate getters/setters for
  it](https://github.com/rustwasm/wasm-bindgen/issues/1284)
