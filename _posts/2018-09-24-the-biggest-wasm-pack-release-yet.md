---
title:  "The Biggest wasm-pack Release Yet"
---

We've just published `wasm-pack` version 0.5.0! This release is by far the
largest `wasm-pack` release we've made so far. We finally have the Rust and
WebAssembly workflow we've always dreamed of. Yes, details will change in the
future (and most likely in semver-breaking ways), but `wasm-pack` has found its
niche and is well on the way to filling it.

> What is `wasm-pack`? `wasm-pack` is your one-stop shop for building and
> testing Rust-generated WebAssembly, as well as publishing it to NPM.

`wasm-pack build` is effectively incremental now. It will automatically Do The
Right Thing with `wasm-bindgen` binary installs: find the exact correct version
*and* cache installs so that re-builds are speedy.

`wasm-pack test` let's you run Rust unit tests in Node.js or headless browsers
via the WebDriver protocol and `wasm-bindgen-test`. Furthermore, it is *easy* to
run tests in headless browsers; a task which usually involves the banging of
head to wall. But `wasm-pack` will transparently download, cache, and configure
WebDriver clients for you &mdash; no more head ache.

Also, [`wasm-pack` got a Website](https://rustwasm.github.io/wasm-pack/) and it
has pre-built binaries for common architectures and operating systems, so
installing `wasm-pack` is a breeze 🌬️

## Changelog

To learn more about these new features &mdash; and everything about the 0.5.0
release &mdash; [read `wasm-pack`'s CHANGELOG.md!](https://github.com/rustwasm/wasm-pack/blob/master/CHANGELOG.md#%EF%B8%8F-050)

## Friends 💖

A huge thank you to everyone who contributed to this `wasm-pack` release!

- Alex Crichton
- Ashley Williams
- Eduard Kyvenko
- Erick Tryzelaar
- Hendrik Sollich
- Ian Duke
- Mackenzie Clark
- Mason Stallmo
- Michael Gattozzi
- Nick Fitzgerald
- Nik Graf
- Spencer Wilson
- Sven Sauleau
- Tyler Wilcock
- Yuval Kohavi
- ashley williams
- csmoe
- data-pup
