---
title: Announcing the js-sys crate!
date: 2018-07-26
---

We've just published the [`js-sys` crate on crates.io][js-sys]!

The `js-sys` crate contains raw `#[wasm_bindgen]` bindings to all the global
APIs guaranteed to exist in every JavaScript environment by the ECMAScript
standard. It does *not* contain bindings to any Web- or Node-specific APIs. With
the `js-sys` crate, we can work with `Object`s, `Array`s, `Function`s, `Map`s,
`Set`s, etc... without writing the `#[wasm_bindgen]` imports by hand.

For example, we can invoke JavaScript `Function` callbacks and time how long
they take to execute with `Date.now()`, and we don't need to write any JS
imports ourselves:

{% highlight rust %}
extern crate js_sys;
extern crate wasm_bindgen;
use wasm_bindgen::prelude::*;

#[wasm_bindgen]
pub fn timed(callback: &js_sys::Function) -> f64 {
    let then = js_sys::Date::now();
    callback.apply(JsValue::null(), &js_sys::Array::new()).unwrap();
    let now = js_sys::Date::now();
    now - then
}
{% endhighlight %}

The `js-sys` crate isn't quite 100% feature complete yet. There are still some
JavaScript types and methods that we don't have bindings for. If you want to
help cross the finish line, [check out this issue!][issue]

Finally, a ***HUGE*** thank you to the 34 people who have contributed to the
`js-sys` crate thus far!

- Alexander Kryvomaz
- Alex Crichton
- belfz
- Chris Kolodin
- Craig Disselkoen
- data-pup
- Dimitrii Nemkov
- gaurikholkar
- Herman J. Radtke III
- Ivan Enderlin
- Jannik Keye
- Johannes Henninger
- Jonathan Sundqvist
- Kevin Hoffman
- kzvi
- Lachezar Lechev
- Liigo Zhuang
- Marcin Baraniecki
- Matias Insaurralde
- Matt Long
- Michael Hoffmann
- Nick Fitzgerald
- R. Andrew Ohana
- robertdurst
- Satoshi Amemiya
- Sendil Kumar
- Stephan Renatus
- Tim Ryan
- T. Nagasawa
- Tomohide Takao
- toversus
- Tyler Laing
- Tyler Wilcock
- xeqlol

[js-sys]: https://crates.io/crates/js-sys
[issue]: https://github.com/rustwasm/wasm-bindgen/issues/275
