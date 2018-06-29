---
title: Our Vision for wasm-bindgen
---

[The last blog post laid out the Rust and WebAssembly domain working group's
overall vision for Rust and WebAssembly.][vision-rust-wasm] In this blog post,
we will dive into the details of `wasm-bindgen`, the future we envision for it,
and *how you can help us build that future*.

[`wasm-bindgen` facilitates communication between JavaScript and Rust compiled
to WebAssembly.][wasm-bindgen] It allows you to speak in terms of Rust structs,
JavaScript classes, strings, etc... instead of only the integers and floats
supported by WebAssembly's raw calling convention. You only pay for what you
use, so using `alert` won't pull in unused bindings for `requestAnimationFrame`.
Additionally, it is designed to support the upcoming ["Host Bindings"
proposal][host-bindings], which will eliminate the need for any kind of
JavaScript shim functions between WebAssembly functions and native DOM
functions. This promises to unlock even-faster-than-JavaScript DOM access, since
DOM API calls can be validated at the time that the WebAssembly is compiled, and
won't need to be dynamically checked on every invocation.

## wasm-bindgen is a Shared Foundation

We are building a shared foundation for an ecosystem of Rust crates that target
JavaScript environments with wasm-bindgen. Sharing a foundation means sharing
raw `extern` imports. Every library that uses the Web's
`window.requestAnimationFrame` function or ECMAScript's `Object.freeze` function
shouldn't need to write the `extern` imports themselves.

Having bindings to all these APIs already in one place should make it easy for
people to write really neat libraries like [MPSC channels built on top of the
`postMessage` API][mpsc] and other utility crates for the Web.

[mpsc]: https://github.com/rustwasm/team/issues/163

### Sharing ECMAScript Global APIs

The global APIs that are available in every JavaScript environment, as defined
by the ECMAScript standard, are being made available through the
`wasm_bindgen::js` module. For example, the `Object.freeze` function is
available as `wasm_bindgen::js::Object::freeze`.

*But we aren't done yet, and we need more help!* Adding more of these global API
bindings is a great way to start with `wasm-bindgen` and there is lots of work
that can be done in concurrent pull requests from various contributors!

**Check out the [ECMAScript global APIs meta issue][js-globals] to help out!**

### Sharing Web APIs

ECMAScript's global APIs aren't the end of the story -- we also need shared
bindings for the Web's DOM APIs, such as `window.requestAnimationFrame`,
`Node.prototype.appendChild`, and `WebSocket`.

All of the Web's API types, functions, and methods are specified with
[WebIDL][webidl], so we are working on a new WebIDL frontend to
`wasm-bindgen`. When the WebIDL frontend is ready, we plan on taking the
interface definitions for all the Web APIs from all their standards and
automatically generating a big `-sys` style crate from them.

What do we mean by a new "frontend"? Recall the simplified description of
`wasm-bindgen`'s architecture today from the last blog post. It is a procedural
macro that parses `#[wasm_bindgen]` annotations that describe `extern`
JavaScript imports and Rust things to export to JavaScript into an abstract
syntax tree (AST). Then, it walks the AST and produces two results: Rust glue to
use imported JavaScript things, JavaScript glue to use exported Rust things. We
call the code responsible for parsing `#[wasm_bindgen]` declarations into the
AST the "procedural macro frontend".

<style>
img {
  max-height: 300px;
  max-width: 300px;
}
</style>

[![wasm-bindgen's current architecture](/images/wasm-bindgen-architecture-current.png)](/images/wasm-bindgen-architecture-current.png)

With the WebIDL frontend, we are introducing a new way to create the AST:
parsing WebIDL and turning its definitions into `wasm-bindgen`'s AST. When using
the WebIDL frontend, there are no `#[wasm_bindgen]` annotations or procedural
macros involved anymore, but the rest of the pipeline after the AST is
constructed is the same.

[![wasm-bindgen's new architecture with a WebIDL frontend](/images/new-wasm-bindgen-architecture.png)](/images/new-wasm-bindgen-architecture.png)

Does this sound cool to you? **Check out [issues labeled "frontend:webidl" in
the `wasm-bindgen` repository][webidl-issues] to help us build the WebIDL
frontend!** The WebIDL frontend's code lives in `wasm-bindgen/crates/webidl`,
and if you have any questions, don't hesitate to ping `fitzgen` in `#rust-wasm`
on irc.mozilla.org or drop a comment in the relevant issue.

Special shout out to [`@ohanar`][ohanar], who has been doing a wonderful job
adding support for converting various WebIDL constructs into `wasm-bindgen`'s
AST! We need more folks like `@ohanar` willing to step up in the same way. 🙏

[ohanar]: https://github.com/ohanar
[vision-rust-wasm]: https://rustwasm.github.io/2018/06/25/vision-for-rust-and-wasm.html
[host-bindings]: https://github.com/WebAssembly/host-bindings/blob/master/proposals/host-bindings/Overview.md
[wasm-bindgen]: https://github.com/rustwasm/wasm-bindgen
[readme]: https://github.com/rustwasm/wasm-bindgen/blob/master/README.md
[design]: https://github.com/rustwasm/wasm-bindgen/blob/master/DESIGN.md
[contributing]: https://github.com/rustwasm/wasm-bindgen/blob/master/CONTRIBUTING.md
[webidl-issues]: https://github.com/rustwasm/wasm-bindgen/issues?q=is%3Aissue+is%3Aopen+label%3Afrontend%3Awebidl
[more-types]: https://github.com/rustwasm/wasm-bindgen/issues?q=is%3Aissue+is%3Aopen+label%3Amore-types
[typescript-issues]: https://github.com/rustwasm/wasm-bindgen/issues?q=is%3Aissue+is%3Aopen+label%3Afrontend%3Atypescript
[js-globals]: https://github.com/rustwasm/wasm-bindgen/issues/275
[webidl]: https://heycam.github.io/webidl/
