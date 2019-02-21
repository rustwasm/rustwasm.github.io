---
title:  "This Week in Rust and WebAssembly 11"
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

## News and Blog Posts from Around the Web

*Want to make sure something ends up on this list next time we publish an issue?
[Leave a comment on this issue.](https://github.com/rustwasm/team/issues/79)*

* [Parsing and rendering PSD files in the browser with Rust and
  WebAssembly](https://twitter.com/chinedufn/status/1098418821591957504)
* [Programmatically generating Islamic
  stars](https://twitter.com/fitzgen/status/1097941877884473344) using the
  "Polygons in Contact" method with Rust-generated Wasm and Web GL
  * [Live demo](https://johanneshoff.com/geotoy/)
  * [Source](https://github.com/fitzgen/geotoy)
* [Dust is a renderer written in Rust that has a backend for Wasm and Web
  GL](https://twitter.com/AsgerNyman/status/1096389338211016705)
  * [Live demo](https://asny.github.io/spider-web/index.html)
  * [Source](https://github.com/asny/Dust)

## Updates from [`rustwasm/*`](https://github.com/rustwasm)

### RFCs

#### New RFCs

None.

#### Merged RFCs

None.

### `console_error_panic_hook`

* @fitzgen [added error
  stacks](https://github.com/rustwasm/console_error_panic_hook/pull/10) to the
  message we log when a panic occurs. This works around bugs in both Safari's
  and Firefox's developer tools consoles.

### `js-sys`

* @Pauan [added convenience getters to
  `js_sys::Reflect`](https://github.com/rustwasm/wasm-bindgen/pull/1225) for
  getting properties keyed by `u32` and `f64`.

### Twiggy🌱

* @data-pup [fixed some unused-result
  warnings](https://github.com/rustwasm/twiggy/pull/243) in Twiggy's parser.

### `walrus`

* @alexcrichton made [GC'ing unused functions, globals, etc an explicit
  pass](https://github.com/rustwasm/walrus/pull/60) in `walrus`. It was
  previously performed implicitly as part of serializing a wasm module.
* @alexcrichton [implemented support for the reference types
  proposal](https://github.com/rustwasm/walrus/pull/50) and `anyref` in
  `walrus`.
* @fitzgen [added the ability to explicitly
  delete](https://github.com/rustwasm/walrus/pull/58) various wasm constructs
  (functions, tables, etc) from a wasm module, rather than just implicitly
  delete them by making them unused and then running a GC.

### `wasm-bindgen`

* @alexcrichton added support for [`Option<MyRustStruct>` in parameters and
  return positions](https://github.com/rustwasm/wasm-bindgen/pull/1275).
* @alexcrichton [added experimental support for using
  `anyref`](https://github.com/rustwasm/wasm-bindgen/pull/1002) in
  `wasm-bindgen`.
* @fitzgen [fixed a
  regression](https://github.com/rustwasm/wasm-bindgen/pull/1255) where DWARF
  debug info custom sections were always being included in the generated Wasm,
  even when debug info was not enabled.
* @alexcrichton [added a
  flag](https://github.com/rustwasm/wasm-bindgen/pull/1256) to control whether
  the producers custom section is included in the generated wasm binary or not.
* @ctjhoa [fixed some deprecation
  warnings](https://github.com/rustwasm/wasm-bindgen/pull/1259) around the use
  of `ATOMICS_*_INIT` instead of `Atomic*::new`.

### `wasm-snip`

* @fitzgen ported `wasm-snip` over to [using the `walrus`
  crate](https://github.com/rustwasm/wasm-snip/pull/21). This also removes the
  need to `wasm-gc` again after running `wasm-snip`.

### `web-sys`

* @selaux [added a missing Web IDL
  attribute](https://github.com/rustwasm/wasm-bindgen/pull/1248) to
  `HTMLMediaElement` so that `web-sys` correctly generates bindings to the
  `srcObject` property.

### `wee_alloc`

* [**We released `wee_alloc` version 0.4.3!
  🎉**](https://github.com/rustwasm/wee_alloc/blob/master/CHANGELOG.md#043)
  Among other things, this version will work on stable Rust as soon as 1.33 is
  released, which is scheduled for one week from today: 2019-02-28.

## Requests for Contribution

**Want to get involved in Rust and WebAssembly? [Join the Rust and WebAssembly
working group!][get-involved]**

* [All issues labeled "good first issue" in the `rustwasm/*` repositories](https://github.com/issues?q=is%3Aopen+is%3Aissue+user%3Arustwasm+archived%3Afalse+label%3A%22good+first+issue%22)
* [All issues labeled "help wanted" in the `rustwasm/*` repositories](https://github.com/issues?q=is%3Aopen+is%3Aissue+user%3Arustwasm+archived%3Afalse+label%3A%22help+wanted%22)

[get-involved]: https://github.com/rustwasm/team/blob/master/README.md#get-involved

### New Good First Issues

* [`wasm-bindgen`: Handling `undefined` arguments](https://github.com/rustwasm/wasm-bindgen/issues/1270)
* [`wasm-bindgen`: Add doc comments from Rust to generated TypeScript
  definitions](https://github.com/rustwasm/wasm-bindgen/issues/1276)
