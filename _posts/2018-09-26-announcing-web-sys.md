---
title:  "Announcing the web-sys crate!"
---

**We are pleased to announce the first release of [the `web-sys`
crate!](https://rustwasm.github.io/wasm-bindgen/web-sys/index.html) It provides
raw bindings to all the Web's APIs: everything from DOM manipulation to WebGL to
Web Audio to timers to `fetch` and more!**

Almost three months ago, we laid out [our vision for
`wasm-bindgen`:](../../07/02/vision-for-wasm-bindgen.html)

> We are building a shared foundation for an ecosystem of Rust crates that
> target JavaScript environments with `wasm-bindgen`. Sharing a foundation means
> sharing raw `extern` imports. Every library that uses the Web's
> `window.requestAnimationFrame` function or ECMAScript's `Object.freeze`
> function shouldn't need to write the `extern` imports themselves.

We observed that the Web has a *huge* number of APIs and that adding support for
all of them by hand would be a Sisyphean task. However, all these APIs are
standardized with the same interface definition language, and we realized that
we could leverage that to mechanically generate a crate containing every single
Web API:

> All of the Web’s API types, functions, and methods are specified with
> [WebIDL](https://heycam.github.io/webidl/), so we are working on a new WebIDL
> frontend to `wasm-bindgen`. When the WebIDL frontend is ready, we plan on
> taking the interface definitions for all the Web APIs from all their standards
> and automatically generating a big `-sys` style crate from them.

<a style="max-width: 300px; float: right; padding: 1.5em; font-size: 80%" href="/images/new-wasm-bindgen-architecture.png">
  <img alt="wasm-bindgen's new architecture with a WebIDL frontend"
       src="/images/new-wasm-bindgen-architecture.png"/>
  `wasm-bindgen`'s new architecture with its WebIDL frontend.
</a>

This plan has finally been realized in the `web-sys` crate! We added a frontend
to `wasm-bindgen` that slurps in WebIDL interface definitions and emits
`wasm-bindgen`'s internal abstract syntax tree (AST). This frontend is the
`wasm-bindgen-webidl` crate. Once we have the AST, emitting zero-overhead Rust
and JavaScript glue code to do type conversion and shepherding of function
parameters and return values is the same as normal `#[wasm_bindgen]`
annotations.

Is using WebIDL to mechanically generate glue code a new idea? Nope! This is the
same battle-tested strategy that every browser engine uses to generate
JavaScript-to-C++ glue code (or in [Servo's](https://servo.org/) case,
JavaScript-to-Rust) for its implementation of these APIs. Furthermore, it is yet
another way that `wasm-bindgen` is future-compatible with [the host bindings
proposal.](https://github.com/WebAssembly/host-bindings/blob/master/proposals/host-bindings/Overview.md)
The host bindings proposal will allow WebAssembly to directly call into native
DOM methods without going through a JavaScript shim, promising to eventually
unlock even-faster-than-JS DOM performance since calls from wasm can be
statically validated to type check once at compilation time, rather than
dynamically on every single call. The proposal suggests that the interface to
the host's bindings be generated mechanically from WebIDL, and we are doing
exactly that.

<div style="clear: both"/>

<style>h2, h3 { margin-top: 15px; }</style>

## The `js-sys` crate is 100% feature complete!

A related bit of news is that [the `js-sys`
crate](https://rustwasm.github.io/2018/07/26/announcing-the-js-sys-crate.html)
is now 100% feature complete! It contains raw bindings to every ECMAScript API
(those APIs that are available both in Node.js and on the Web and any other JS
environment).

Unlike the `web-sys` crate, these are written by hand because there is no WebIDL
describing these APIs. That would have been great to have, both because it would
have been easier to implement the `js-sys` crate, and because we would have
avoided bugs along the way. We considered a TypeScript frontend, but did not
prioritize it because TypeScript does not describe whether or not functions
throw exceptions.

## Example Programs

[We have a growing list of examples of using `web-sys`, `js-sys`, and
`wasm-bindgen`
together!](https://rustwasm.github.io/wasm-bindgen/examples/index.html) The
following programs are a small selection of these.

### A Simple Paint Program with 2D Canvas

Click and drag to draw!

[More information and source code.](https://rustwasm.github.io/wasm-bindgen/examples/paint.html)

<iframe src="https://rustwasm.github.io/wasm-bindgen/exbuild/paint/" style="min-width: 662px; min-height: 502px;"></iframe>

### An FM Synthesizer with Web Audio

This example creates an [FM
synthesizer](https://en.wikipedia.org/wiki/Frequency_modulation_synthesis) using
the [WebAudio
API](https://developer.mozilla.org/en-US/docs/Web/API/Web_Audio_API) and
`web-sys`.

[More information and source code.](https://rustwasm.github.io/wasm-bindgen/examples/web-audio.html)

<iframe src="https://rustwasm.github.io/wasm-bindgen/exbuild/webaudio/" style="width: 100%;"></iframe>

## Friends 💖

### Contributors to `web-sys` and `wasm-bindgen-webidl`

Huge thanks to everyone who helped build the `web-sys` crate and the Web IDL
frontend for `wasm-bindgen` that made the `web-sys` crate possible!

- afdw
- Alex Crichton
- Andrew Chin
- Anton Danilkin
- Benjamin Kampmann
- Ben Merritt
- Jonathan Kingston
- Julius Rakow
- Michael Hoffmann
- Nick Fitzgerald
- R. Andrew Ohana
- Richard Dodd (dodj)
- Ruben Schmidmeister
- Sendil Kumar N
- Stephan Wolski
- teovoinea
- twilco
- Tyler Wilcock
- YUyz

### Contributors to `js-sys`

A second round of applause for everyone who contributed to the `js-sys` crate!

- Alexander Kryvomaz
- Alex Crichton
- Andrew Chin
- Anton Danilkin
- belfz
- bokuweb
- Camille TJHOA
- Chris Kolodin
- Craig Disselkoen
- Danielle Pham
- data-pup
- Dimitrii Nemkov
- Frazer McLean
- gaurikholkar
- Herman J. Radtke III
- Ivan Enderlin
- Jannik Keye
- Joel Gallant
- Johannes Henninger
- Jonas Trollvik
- Jonathan Sundqvist
- Kevin Hoffman
- kzvi
- Lachezar Lechev
- Liigo Zhuang
- Marcin Baraniecki
- Mason Stallmo
- Matias Insaurralde
- Matt Kraai
- Matt Long
- Michael Hoffmann
- Nick Fitzgerald
- R. Andrew Ohana
- robertdurst
- Roberto Huertas
- Satoshi Amemiya
- Sendil Kumar N
- sepiropht
- Stephan Renatus
- Thomas Eizinger
- Tim Ryan
- T. Nagasawa
- Tomohide Takao
- toversus
- Tyler Laing
- Tyler Wilcock
- xeqlol
