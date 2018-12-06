---
layout: post
title: "Reflecting on Rust and WebAssembly in 2018"
---

[**🎉 The 2018 edition of Rust has officially shipped, and the initial Rust and
WebAssembly development story along with it! 🎉**][rust-2018]

To see how far we've come, let's reflect on the Rust and WebAssembly story a
year ago: `rustc` could emit WebAssembly binaries for you, but that was about
it. As far as communication with JavaScript went, you had to work with raw wasm
imports and exports yourself. That meant you could only pass 32- and 64-bit
integers and floats back and forth. No Rust structs, JavaScript objects,
strings, or slices could be passed back forth. And distributing your library's
`.wasm` so that other downstream projects could depend on it? Good luck.

While it was [clear there was huge potential for Rust and
WebAssembly][case-for-rust-wasm-2018], no one was sure what exactly that
meant. So when the Rust and WebAssembly domain working group formed, we rallied
around making this shared vision into a reality:

> #### Compiling Rust to WebAssembly should be the best choice for fast, reliable code for the Web.

As our ideas evolved, we distilled another core value:

> #### Rust and WebAssembly is here to *augment* your JavaScript, not replace it.

The same way that Rust integrates with C libraries and calling conventions on
native targets, it should play nice with JavaScript and HTML5 APIs on the
Web. You should *not* have to rewrite your whole Web application or JavaScript
library. We cannot realize our vision for Rust and wasm if it means you have to
start over from scratch; it wouldn't be practical.

Given these shared values and vision, we set out goals for what we wanted the
Rust and WebAssembly ecosystem, toolchain, and workflow to look like by the time
Rust 2018 shipped.

### Goal: ☑ Zero-Cost JavaScript Interoperation

Rust enables fast *and* expressive code by leveraging zero-cost abstractions. We
wanted to apply this principal to our whole JS interop infrastructure. Yes, you
can write your own boilerplate to pass DOM nodes to Rust-generated wasm, but you
shouldn't have to, and the provided infrastructure should be as fast as if you
*did* hand-code it. If you call IndexedDB APIs, that shouldn't bloat your
`.wasm` binary with unused bindings to Web GL functions.

[We created `wasm-bindgen` as the foundation for zero-cost JavaScript
interoperation.][wasm-bindgen] `wasm-bindgen` facillitates communication between
JavaScript and WebAssembly, and generates glue code that you would otherwise
have to write yourself. On top of `wasm-bindgen`, [we built `js-sys` (raw
bindings to ECMAScript APIs) and `web-sys` (raw bindings to Web
APIs)][announcing-web-sys].

Using the `wasm-bindgen` ecosystem, we can easily and performantly

* export rich APIs from our Rust-generated wasm libraries, so they are callable
  from JavaScript, and
* import JavaScript and Web APIs into our Rust-generated wasm.

All in a zero-cost manner.

Additionally, `wasm-bindgen` is forward-compatible with the [WebAssembly host
bindings proposal][host-bindings]. Host bindings will remove the tiny, generated
JavaScript shim functions that sit between our wasm functions and DOM
methods. Eventually, host bindings promises to unlock
even-faster-than-JavaScript DOM access since calls can be statically validated
once rather than dynamically checked every time.

### Goal: ☑ Distributing Rust-Generated Wasm as an NPM Library

Superb integration isn't only about exporting and importing functionality
between Rust-generated WebAssembly and JavaScript. It is also fitting into the
JavaScript's distribution mechanisms, and a big chunk of that story is
[NPM][].

We [built `wasm-pack`][wasm-pack] to make it easy to create and publish NPM
packages from your Rust and WebAssembly code. There didn't used to be any story
whatsoever for sharing Rust-generated wasm modules. Now, all it takes is:

```
wasm-pack publish
```

### Goal: ☑ Get Developers Productive Fast

We wrote [a Rust and WebAssembly book][book] that teaches you all the ins and
outs of WebAssembly development with Rust. It features [a tutorial where you
build an implementation of Conway's Game of Life][tutorial], and then you learn
to write tests for headless browsers, debug wasm code when things go wrong, and
how to diagnose slow code paths and then speed them up.

We realized that there are a bunch of "post-build" tools you want to run after
`cargo` and `rustc` emit the initial `.wasm` binary. For usability and developer
productivity, we expanded `wasm-pack`'s role from creating and publishing NPM
packages to orchestrating all of these tasks. `wasm-pack` will manage your
`wasm-bindgen` CLI binaries and install browsers' WebDriver clients for you
automatically.

For example, want to run tests in a headless Firefox browser? Just run

```
wasm-pack test --headless --firefox
```

No need to pull your hair out trying to install and configure anything!

Finally, we recognized that getting your Rust and WebAssembly project set up
initially involves a bit of boilerplate and configuration that new users aren't
prepared for and experienced users don't want to waste time on. So we created a
variety of project templates for different use cases, so you can hit the ground
running:

* [`wasm-pack-template`][wasm-pack-template] for creating NPM libraries with
  Rust and Wasm.
* [`create-wasm-app`][create-wasm-app] for creating Web applications built on
  top of Rust-generated wasm NPM libraries.
* [`rust-webpack-template`][rust-webpack-template] for creating whole Web
  applications with Rust, WebAssembly, and the Webpack bundler.
* [`rust-parcel-template`][rust-parcel-template] for creating whole Web
  applications with Rust, WebAssembly, and the Parcel bundler.

### Goal: ☑ Rust-Generated Wasm Should be Testable and Debuggable

We recognized that testing and debugging infrastructure are table stakes for
creating reliable code and developer productivity.

By default, wasm can't log any panics or errors because it doesn't have any
"syscall" or I/O functionality. You have to add imports for that sort of thing
yourself, and then instantiate the module with the appropriate functions. To
remedy this problem, and to ensure that panics are always debuggable, we created
[the `console_error_panic_hook` crate][console_error_panic_hook], which
redirects panic messages into the browser's devtools console.

While you can always run normal `#[test]`s on the native target for portable,
platform-agnostic code, that isn't sufficient for testing your library's
interaction with the DOM, asynchronous JavaScript promises, or event
handlers. So we created [the `wasm-bindgen-test`
infrastructure][wasm-bindgen-test], and made installing and configuring the
necessary binaries for headless browser and Node.js testing a breeze with
`wasm-pack test`.

We also had experienced that diagnosing where code size was coming from could be
hard with WebAssembly. We wanted to know things like which function was calling
another function, and causing it to be included in the `.wasm` binary, so we
created [the Twiggy🌱 code size profiler for WebAssembly][twiggy].

```
 Shallow Bytes │ Shallow % │ Retaining Paths
───────────────┼───────────┼───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
           152 ┊     5.40% ┊ wee_alloc::alloc_with_refill::hb32c1bbce9ebda8e
               ┊           ┊   ⬑ func[2]
               ┊           ┊       ⬑ <wee_alloc::size_classes::SizeClassAllocPolicy<'a> as wee_alloc::AllocPolicy>::new_cell_for_free_list::h3987e3054b8224e6
               ┊           ┊           ⬑ func[5]
               ┊           ┊               ⬑ elem[0]
               ┊           ┊       ⬑ hello
               ┊           ┊           ⬑ func[8]
               ┊           ┊               ⬑ export "hello"
```

## #RustWasm2019

All of our goals have been focused on things we could deliver in tandem with the
2018 edition. But now that the 2018 edition has shipped, it is time to think
about what we want to achieve in 2019 and beyond.

**This is where you come in!**

Following in the larger Rust project's [tradition][rust-2019-call-for-blogs],
we're asking the community to write blog posts reflecting on Rust and
WebAssembly in 2018 and proposing goals and directions for Rust and WebAssembly
in 2019. We'll read everything, and then propose an [RFC][rust-wasm-rfcs] for
the Rust and WebAssembly domain working group's roadmap in 2019.

Write down your thoughts on whatever your writing platform of choice is. It
could be:

* Your personal or company blog
* A GitHub gist
* A Medium post
* Any other platform you prefer

We're looking for posts on many different topics:

* Ideas for community programs
* Tooling enhancements
* Ecosystem and library needs
* Documentation improvements
* Anything else related to Rust and Wasm!

Tweet your write up with [the `#RustWasm2019` hashtag][hashtag] or drop a link
on [this github issue][rust-wasm-2019-issue]. We'll aggregate everything
everyone has written in another big post on this blog. Then, the core Rust and
WebAssembly working group team will read over all of them and write up an RFC
for the working group's 2019 roadmap! This RFC will follow our normal [RFC
process][] and everyone will have a chance to discuss it, improve it, and help
polish it.

## Preliminary Timeline

* **Now through January 15<sup>th</sup>:** Share your `#RustWasm2019` post, read
  posts by others, discuss them, bounce ideas back and forth.
* **End of January:** We'll formally propose the 2019 roadmap RFC, and then work
  it through the RFC process together as a community.
* **End of February:** We're aiming for having consensus on the 2019 roadmap and
  merging the RFC before the end of February.

## Thank You for a Wonderful 2018! 💖

Thanks to everyone who contributed to Rust and WebAssembly in 2018! (Apologies
if we missed anyone in this list!)

* 0xazure
* Aaron Turon
* Aditya Arora
* Aidan Hobson Sayers
* Aleksey Kladov
* Alex Crichton
* Alex Macleod
* Alexander Kryvomaz
* Alfie John
* Anders Pitman
* Andrew Champion
* Andrew Chin
* Andy Bell
* Anna Bogus
* Anton Danilkin
* Ashley Williams
* Ben Merritt
* Benjamin Kampmann
* Blixt
* Bradlee Speice
* Cameron Taggart
* Camille TJHOA
* Chinedu Francis Nwafili
* Chris Goller
* Chris Kolodin
* Christian Bourjau
* Christopher Lane Hinson
* Cldfire
* Corbin Uselton
* Corey Farwell
* Craig Disselkoen
* Dan Fockler
* Dan Reeves
* Daniel Gollahon
* Daniele Esposti
* Danielle Pham
* Darren Tsung
* David Flemström
* David McNeil
* David O'Connor
* DebugSteven
* Dimitrii Nemkov
* Dmitry Kashitsyn
* Eduard Kyvenko
* Erick Tryzelaar
* Erika Kloss
* Evan Shaw
* Felix Schütt
* Florian Gilcher
* Frank Hassanabad
* Frazer McLean
* Gergely Nagy
* Guy Waldman
* Hendrik Sollich
* Henrik Sjööh
* Herman J. Radtke III
* Hidehito Yabuuchi
* Ian Duke
* Ian McIntyre
* Ingvar Stepanyan
* Ioannis Valasakis
* Ivan Enderlin
* J. Ryan Stinnett
* Jamen Marz
* Jamie Kyle
* Jan Willem Henckel
* Jan-Erik Rediger
* Jannik Keye
* Jason Davies
* Jason Wohlgemuth
* Jesper Håkansson
* Jim Blandy
* Joel Gallant
* Johann Hofmann
* Johannes Henninger
* John Lewis
* Jonas Trollvik
* Jonathan Kingston
* Jonathan Sundqvist
* Josh Triplett
* Joshua Liebow-Feeser
* Joshua Sheard
* Josmar Dias
* João Lucas Lucchetta
* Julius Rakow
* Junjie Huang
* Katharina Fey
* Kevin Hoffman
* Kirill Bulatov
* Kyle Lin
* Lachezar Lechev
* Laurentiu Nicola
* Liigo Zhuang
* LongYinan
* Luke Wagner
* Mackenzie Clark
* Mackiovello
* Manas Karekar
* Marcin Baraniecki
* Mario Reder
* Mark Andrus Roberts
* Mark Hintz
* Markus Stange
* Mason Stallmo
* Matias Insaurralde
* Matt Harrison
* Matt Howell
* Matt Kraai
* Matt Long
* MaxD / vj userZero
* MaxXor
* Michael Gattozzi
* Michael Gerhaeuser
* Michael Hoffmann
* Mirclus
* Nathan Froyd
* Nick Fitzgerald
* Nik Graf
* Nikolay Volf
* Noah Lemen
* Noumir Poutipou
* OJ Kwon
* Pascal Brandt
* Pascal Hertleif
* Pat Hickey
* Peter Trotman
* R. Andrew Ohana
* Rahul Sharma
* Ralph Giles
* Renée Kooi
* Ricardo Ambrogi
* Richard Dodd (dodj)
* Robert Masen
* Roberto Huertas
* Rongjian Zhang
* Ruben Schmidmeister
* Ryan Levick
* Sallar Kaboli
* Santiago Pastorino
* Satoshi Amemiya
* Scott Johnson
* Sebastian Köln
* Sendil Kumar N
* Sergey Pepyakin
* Sharad Chand
* Sonny Scroggin
* Sophie Alpert
* Spencer Wilson
* Stefan Novak
* Stefan Zimmermann
* Stephan Renatus
* Stephan Wolski
* Steve Klabnik
* Sven Sauleau
* T. Nagasawa
* Tao He
* Ted Mielczarek
* Theemathas Chirananthavat
* Thiago Pontes
* Thomas Eizinger
* Tim Ryan
* Tobias Bieniek
* Tomohide Takao
* Tomáš Hübelbauer
* Tyler Laing
* Tyler Wilcock
* William Lundstedt
* YUyz
* Yoshua Wuyts
* Yury Delendik
* Yuval Kohavi
* Zachary Pierce
* Zack Pierce
* afdw
* alkahest
* andy-bell
* arjunyel
* ashley williams
* belfz
* bokuweb
* bspeice
* csmoe
* data-pup
* dependabot[bot]
* frankhassanbad
* gaurikholkar
* gnzlbg
* huangjj27
* janczer
* johnthagen
* kohensu
* konstin
* kryptan
* kzvi
* limira
* na-g
* pup
* robert masen
* robertdurst
* sarahmeyer
* sepiropht
* sigmaSd
* soryrawyer
* teovoinea
* toversus
* twilco
* xeqlol

[rust-2018]: https://blog.rust-lang.org/2018/12/06/Rust-1.31-and-rust-2018.html
[case-for-rust-wasm-2018]: https://mgattozzi.com/rust-wasm/
[rust-2019-call-for-blogs]: https://blog.rust-lang.org/2018/12/06/call-for-rust-2019-roadmap-blogposts.html
[rust-wasm-rfcs]: https://github.com/rustwasm/rfcs
[hashtag]: https://twitter.com/search?q=%23RustWasm2019
[rust-wasm-2019-issue]: https://github.com/rustwasm/team/issues/241
[RFC process]: https://rustwasm.github.io/rfcs/001-the-rfc-process.html
[Bjarne Stroustrup]: https://en.wikipedia.org/wiki/Bjarne_Stroustrup
[announcing-web-sys]: https://rustwasm.github.io/2018/09/26/announcing-web-sys.html
[wasm-bindgen]: https://github.com/rustwasm/wasm-bindgen
[host-bindings]: https://github.com/WebAssembly/host-bindings/blob/master/proposals/host-bindings/Overview.md
[NPM]: https://www.npmjs.com/
[wasm-pack]: https://github.com/rustwasm/wasm-pack
[book]: https://rustwasm.github.io/book/
[tutorial]: https://rustwasm.github.io/book/game-of-life/introduction.html
[wasm-pack-template]: https://github.com/rustwasm/wasm-pack-template
[create-wasm-app]: https://github.com/rustwasm/create-wasm-app
[rust-webpack-template]: https://github.com/rustwasm/rust-webpack-template
[rust-parcel-template]: https://github.com/rustwasm/rust-parcel-template
[console_error_panic_hook]: https://github.com/rustwasm/console_error_panic_hook
[wasm-bindgen-test]: https://rustwasm.github.io/wasm-bindgen/wasm-bindgen-test/index.html
[twiggy]: https://github.com/rustwasm/twiggy
