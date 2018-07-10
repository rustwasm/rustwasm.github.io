---
title:  "This Week in Rust and WebAssembly 004"
---

Hello and welcome to another issue of *This Week in Rust and WebAssembly*!

[Rust](https://rust-lang.org) is a systems language pursuing the trifecta: safety, concurrency, and speed.

[WebAssembly](http://webassembly.org) is a stack-based virtual machine and instruction set. It is fast, safe, portable, and part of the open Web platform. By compiling to WebAssembly, we can run Rust code on the Web!

This is a weekly summary of Rust and WebAssembly's progress and community.

Did we miss something? Tweet to us at [@rustwasm](https://twitter.com/rustwasm) or [send us a pull request](https://github.com/rustwasm/rustwasm.github.io).

**Want to get involved in Rust and WebAssembly? [Join the Rust and WebAssembly working group!][get-involved]**

## New Tools, Crates, and Projects

* [Project Ice Puzzle](http://www.matthewmichelotti.com/games/project_ice_puzzle/) is a game made with Rust and WebAssembly.
* [wasmbooth](https://mtharrison.github.io/wasmbooth/) is a video effect booth written in Rust and WebAssembly.
* [wasmparse-{core,bridge,web}](https://github.com/mtharrison/wasmparse-core) is a browser-based interactive Wasm  disassembler (in-progress). Its goal is to teach people about the webassembly format, webassembly code and how the stack machine works. The cool thing is it is also be written in Rust and compiled to wasm. Wasm all the way down!
* [Try `nphysics3d` demos in your desktop browser!](https://www.reddit.com/r/rust/comments/8pvgpb/try_nphysics3d_demos_on_your_desktop_browser/)

## News and Releases

* [Announcing `wasm-pack` 0.4.0!](https://github.com/rustwasm/wasm-pack/blob/master/CHANGELOG.md#-040)
* [Announcing Twiggy 0.2.0!](https://users.rust-lang.org/t/announcing-twiggy-version-0-2-0/18312)
* [Announcing `wee_alloc` 0.4.1!](https://github.com/rustwasm/wee_alloc/blob/master/CHANGELOG.md#041)
* [JPEG decoding via the image crate now works on wasm and asm.js](https://github.com/kaksmet/jpeg-decoder/issues/87)

## Articles, Blog Posts, and Talks

* [**Our Vision for Rust and WebAssembly**](https://rustwasm.github.io/2018/06/25/vision-for-rust-and-wasm.html)
* [**Our Vision for `wasm-bindgen`**](https://rustwasm.github.io/2018/07/02/vision-for-wasm-bindgen.html)
* [Making calls to WebAssembly fast and implementing `anyref` in Firefox](https://blog.benj.me/2018/07/04/mozilla-2018-faster-calls-and-anyref/)
* [Why we believe in Wasm as the base layer of decentralised application development](https://paritytech.io/wasm-smart-contract-development/)
* [Building better compression together with DivANS.](https://blogs.dropbox.com/tech/2018/06/building-better-compression-together-with-divans/) DivANS is a new concurrent, vectorized compression algorithm in Rust, compiled to WASM for high density compression in the browser and on servers.
* Video: [Learn+Try: Rust in the Browser via WebAssembly @ Rust DC, April 12, 2018](https://www.youtube.com/watch?v=btCgzXgmhys)

## RFCs

* [Propose an RFC process based on Rust's but lighter weight.](https://github.com/rustwasm/rfcs/pull/1) This is entering its final comment period!

## Requests for Contribution

* [**Join the Rust and WebAssembly Working Group!**][get-involved]
  * [All issues labeled "good first issue" in the `rustwasm/*` repositories](https://github.com/issues?q=is%3Aopen+is%3Aissue+user%3Arustwasm+archived%3Afalse+label%3A%22good+first+issue%22)
  * [All issues labeled "help wanted" in the `rustwasm/*` repositories](https://github.com/issues?q=is%3Aopen+is%3Aissue+user%3Arustwasm+archived%3Afalse+label%3A%22help+wanted%22)
* [Expose bindings to *ALL* the global JS things](https://github.com/rustwasm/wasm-bindgen/issues/275)
* Help build the `web-sys` crate by enabling bindings generation for more WebIDL interfaces!
  * [Information on contributing to `web-sys`](https://rustwasm.github.io/wasm-bindgen/web-sys.html)
  * [Issues tracking adding various Web APIs to `web-sys`](https://github.com/rustwasm/wasm-bindgen/issues?q=is%3Aissue+is%3Aopen+label%3Aweb-sys)

[get-involved]: https://github.com/rustwasm/team/blob/master/README.md#get-involved

## `rustwasm` Projects Activity

Recently merged pull requests to projects in the [`rustwasm` GitHub
organization][rustwasm-org]:

[rustwasm-org]: https://github.com/rustwasm

#### rustwasm/book

- @fitzgen [GoL tutorial: Remove broken exercise](https://github.com/rustwasm/book/pull/40)
- @alfiedotwtf [Minor grammar fix](https://github.com/rustwasm/book/pull/37)
- @fitzgen [debugging: Mention the `console_error_panic_hook` crate](https://github.com/rustwasm/book/pull/36)
- @alfiedotwtf [Minor grammar fix](https://github.com/rustwasm/book/pull/34)
- @alfiedotwtf [Removed legacy mentions of slow crossing-boundary calling](https://github.com/rustwasm/book/pull/33)
- @xeqlol [Fix typo in tools chapter](https://github.com/rustwasm/book/pull/27)
- @fitzgen [Remove legacy issues link in README](https://github.com/rustwasm/book/pull/24)
- @fitzgen [Fix wasm-pack URL to reflect move to rustwasm org](https://github.com/rustwasm/book/pull/23)
- @mgattozzi [Add issue templates](https://github.com/rustwasm/book/pull/11)
- @nikgraf [switch to camel case for JS code](https://github.com/rustwasm/book/pull/9)
- @migerh [Update links pointing to the old rust-nursery to the new rustwasm organisation](https://github.com/rustwasm/book/pull/6)
- @kylejlin [Require `MYSCOPE` to be your npm username.](https://github.com/rustwasm/book/pull/2)

#### rustwasm/rust_wasm_template

- @acdha [README: prevent sed from creating backup files](https://github.com/rustwasm/rust_wasm_template/pull/11)
- @hockeybuggy [Fix small typo in `CONTRIBUTING.md`](https://github.com/rustwasm/rust_wasm_template/pull/9)
- @sendilkumarn [bump wasm-bindgen to v 2.11](https://github.com/rustwasm/rust_wasm_template/pull/8)
- @xtuc [fix wasm location](https://github.com/rustwasm/rust_wasm_template/pull/7)

#### rustwasm/team

- @fitzgen [Point wasm-bindgen contributors to the "expose js globals" meta issue](https://github.com/rustwasm/team/pull/199)
- @jrichocean [UPDATES open-issue link for book in README.md](https://github.com/rustwasm/team/pull/198)
- @mgattozzi [Set rustwasm/book team goals](https://github.com/rustwasm/team/pull/195)
- @xtuc [Update bundler-integration.md](https://github.com/rustwasm/team/pull/194)
- @fitzgen [Communicate what/why/how of our working group's goals](https://github.com/rustwasm/team/pull/193)
- @fitzgen [Streamline README even more](https://github.com/rustwasm/team/pull/192)
- @fitzgen [Formalize lightweight governance rules](https://github.com/rustwasm/team/pull/191)
- @johlrogge [Add instructions to set nightly as the default tool chain](https://github.com/rustwasm/team/pull/183)

#### rustwasm/twiggy

- @data-pup [Fix paths_test.wat](https://github.com/rustwasm/twiggy/pull/75)
- @csmoe [feat(cfg): gate output format behind cargo feature](https://github.com/rustwasm/twiggy/pull/71)
- @csmoe [[WIP] cargo twiggy](https://github.com/rustwasm/twiggy/pull/70)

#### rustwasm/wasm-bindgen

- @brisad [Add Response interface part of fetch API](https://github.com/rustwasm/wasm-bindgen/pull/452)
- @fitzgen [Move webidl tests to the webidl crate's test suite](https://github.com/rustwasm/wasm-bindgen/pull/451)
- @limira [Add console.log(error); [--no-modules]](https://github.com/rustwasm/wasm-bindgen/pull/440)
- @toVersus [bindings for Date.setXXX](https://github.com/rustwasm/wasm-bindgen/pull/438)
- @rail44 [Add support for methods of Symbol](https://github.com/rustwasm/wasm-bindgen/pull/437)
- @liigo [[doc] fix `ArrayBuffer::is_view()`'s document.](https://github.com/rustwasm/wasm-bindgen/pull/435)
- @alexcrichton [Test in release mode on Travis](https://github.com/rustwasm/wasm-bindgen/pull/431)
- @FreeMasen [Js docs](https://github.com/rustwasm/wasm-bindgen/pull/430)
- @alexcrichton [[WIP] Test out various configurations to speed up CI](https://github.com/rustwasm/wasm-bindgen/pull/429)
- @alexcrichton [Fix some cases with `#[deny(missing_docs)]`](https://github.com/rustwasm/wasm-bindgen/pull/428)
- @alexcrichton [Simplify the `reset_indentation` function](https://github.com/rustwasm/wasm-bindgen/pull/427)
- @toVersus [bindings for Date.getTimezoneOffset and Date.getUTCXXX](https://github.com/rustwasm/wasm-bindgen/pull/426)
- @akryvomaz [bindings for isFinite(), Number.isFinite() and Number.isSafeInteger()](https://github.com/rustwasm/wasm-bindgen/pull/420)
- @belfz [adds julia set example](https://github.com/rustwasm/wasm-bindgen/pull/419)
- @FrankHassanabad [Applied eslint from main .eslintrc to examples](https://github.com/rustwasm/wasm-bindgen/pull/418)
- @FrankHassanabad [Change https to http and make a link to it for ease of read](https://github.com/rustwasm/wasm-bindgen/pull/416)
- @belfz [uses (JS) `const` for stack and slab declarations](https://github.com/rustwasm/wasm-bindgen/pull/415)
- @toVersus [bindings for Date.parse and Date.getXXX](https://github.com/rustwasm/wasm-bindgen/pull/414)
- @limira [Add [hello-online]](https://github.com/rustwasm/wasm-bindgen/pull/413)
- @matiasinsaurralde [Add bindings for `Intl`](https://github.com/rustwasm/wasm-bindgen/pull/412)
- @ohanar [Backend refactor](https://github.com/rustwasm/wasm-bindgen/pull/411)
- @alexcrichton [Generate normal Rust functions for imported bindings](https://github.com/rustwasm/wasm-bindgen/pull/410)
- @fitzgen [Create the `web-sys` crate mechanically from WebIDL](https://github.com/rustwasm/wasm-bindgen/pull/409)
- @limira [Correct link to WebIDL issue](https://github.com/rustwasm/wasm-bindgen/pull/402)
- @rail44 [Add support for static props of Symbol](https://github.com/rustwasm/wasm-bindgen/pull/401)
- @alexcrichton [Forward attributes on `type` declaration to definition](https://github.com/rustwasm/wasm-bindgen/pull/400)
- @alexcrichton [Implement `Debug for JsValue`](https://github.com/rustwasm/wasm-bindgen/pull/399)
- @ZerothLaw [Issue #275: Added Array.prototype.find binding](https://github.com/rustwasm/wasm-bindgen/pull/397)
- @fitzgen [tests: Pull the `project()` builder out into its own crate](https://github.com/rustwasm/wasm-bindgen/pull/396)
- @brisad [Add Array.prototype.values binding](https://github.com/rustwasm/wasm-bindgen/pull/395)
- @fitzgen [js: Return scalar types instead of `Number` objects](https://github.com/rustwasm/wasm-bindgen/pull/394)
- @alexcrichton [Test release builds on Travis](https://github.com/rustwasm/wasm-bindgen/pull/393)
- @brisad [Add bindings in Date and Number](https://github.com/rustwasm/wasm-bindgen/pull/392)
- @frewsxcv [Fix typo in rust-type-conversions.md.](https://github.com/rustwasm/wasm-bindgen/pull/390)
- @alexcrichton [Fix some eslint warnings about unused variables](https://github.com/rustwasm/wasm-bindgen/pull/389)
- @Hywan [feat(js) Add `ArrayBuffer::new`, `::is_view` & `::slice` bindings.](https://github.com/rustwasm/wasm-bindgen/pull/388)
- @Hywan [feat(js) Implement the `WebAssembly.validate` binding.](https://github.com/rustwasm/wasm-bindgen/pull/387)
- @jannikkeye [Reflect.xx bindings](https://github.com/rustwasm/wasm-bindgen/pull/386)
- @toVersus [bindings for date.getDay/getFullYear](https://github.com/rustwasm/wasm-bindgen/pull/385)
- @liigo [bindings for parseInt/parseFloat](https://github.com/rustwasm/wasm-bindgen/pull/384)
- @jannikkeye [doc: add reference document (#242)](https://github.com/rustwasm/wasm-bindgen/pull/383)
- @srenatus [Add bindings for Proxy](https://github.com/rustwasm/wasm-bindgen/pull/382)
- @alexcrichton [Speed up Travis by running Webpack in fewer tests](https://github.com/rustwasm/wasm-bindgen/pull/381)
- @akryvomaz [bindings for Generator.next(), Generator.return() and Generator.throw()](https://github.com/rustwasm/wasm-bindgen/pull/380)
- @belfz [fixes team members table layout](https://github.com/rustwasm/wasm-bindgen/pull/379)
- @jhenninger [Bindings for Math.pow, round, sign, sin, sinh, sqrt, tan, tanh and trunc](https://github.com/rustwasm/wasm-bindgen/pull/378)
- @fitzgen [Add @belfz to the team! \o/](https://github.com/rustwasm/wasm-bindgen/pull/377)
- @sendilkumarn [fix webpack to handle node global functions](https://github.com/rustwasm/wasm-bindgen/pull/375)
- @Hywan [test(js) Fix expectations regarding given locales](https://github.com/rustwasm/wasm-bindgen/pull/374)
- @rail44 [Add support getter and setter for static props ](https://github.com/rustwasm/wasm-bindgen/pull/373)
- @konstin [Fix the constructor explanation in the guide](https://github.com/rustwasm/wasm-bindgen/pull/372)
- @fitzgen [Headless browser testing infrastructure](https://github.com/rustwasm/wasm-bindgen/pull/371)
- @alexcrichton [Add `design.md` to the online mdbook](https://github.com/rustwasm/wasm-bindgen/pull/370)
- @jhenninger [Use f64 for most Math.* bindings](https://github.com/rustwasm/wasm-bindgen/pull/369)
- @alexcrichton [Some small cleanups](https://github.com/rustwasm/wasm-bindgen/pull/366)
- @belfz [implements Object.preventExtensions() binding](https://github.com/rustwasm/wasm-bindgen/pull/364)
- @belfz [Expose bindings/object is* methods](https://github.com/rustwasm/wasm-bindgen/pull/363)
- @belfz [implements Object.values() binding](https://github.com/rustwasm/wasm-bindgen/pull/362)
- @brisad [Bindings for string lower and upper case](https://github.com/rustwasm/wasm-bindgen/pull/361)
- @akryvomaz [bindings for Function.prototype.bind, decodeURIComponent, encodeURIComponent](https://github.com/rustwasm/wasm-bindgen/pull/359)
- @belfz [implements Object.setPrototypeOf() binding](https://github.com/rustwasm/wasm-bindgen/pull/358)
- @kzvi [add more detailed error messages for invalid #[wasm_bindgen] invocations](https://github.com/rustwasm/wasm-bindgen/pull/356)
- @alexcrichton [Don't generate JS bindings for unused imports](https://github.com/rustwasm/wasm-bindgen/pull/355)
- @rail44 [Add support for js::Error](https://github.com/rustwasm/wasm-bindgen/pull/354)
- @fitzgen [Add @sendilkumarn to the team! \o/](https://github.com/rustwasm/wasm-bindgen/pull/352)
- @alexcrichton [Support wildcard arguments in foreign functions](https://github.com/rustwasm/wasm-bindgen/pull/351)
- @alexcrichton [Support returning custom types in imports](https://github.com/rustwasm/wasm-bindgen/pull/350)
- @jannikkeye [Add bindings for Map.xx](https://github.com/rustwasm/wasm-bindgen/pull/349)
- @alexcrichton [Support by-value self methods](https://github.com/rustwasm/wasm-bindgen/pull/348)
- @jannikkeye [Add bindings for Set.xx](https://github.com/rustwasm/wasm-bindgen/pull/347)
- @fitzgen [Add @jonathan-s to the team! \o/](https://github.com/rustwasm/wasm-bindgen/pull/345)
- @autodidaddict [Binding for Math.cos,cosh,exp,expml,fround,imul,log,log10,log1p,log2](https://github.com/rustwasm/wasm-bindgen/pull/344)
- @jannikkeye [feat(Set): add bindings and tests](https://github.com/rustwasm/wasm-bindgen/pull/343)
- @jannikkeye [feat(js): add bindings for Map](https://github.com/rustwasm/wasm-bindgen/pull/342)
- @seako [add bindings for Array.prototype.some()](https://github.com/rustwasm/wasm-bindgen/pull/341)
- @ohanar [Use rustfmt for standarized formatting](https://github.com/rustwasm/wasm-bindgen/pull/340)
- @xeqlol [feat(js): JSON bindings](https://github.com/rustwasm/wasm-bindgen/pull/339)
- @fitzgen [guide: Add note about `static_method_of` attribute to design doc](https://github.com/rustwasm/wasm-bindgen/pull/338)
- @belfz [implements Array.prototype.every()](https://github.com/rustwasm/wasm-bindgen/pull/336)
- @xeqlol [Implement Weakset bindings](https://github.com/rustwasm/wasm-bindgen/pull/335)
- @Hywan [feat(js) Implement `Number.new`, `Date.now` and `Date.UTC` bindings](https://github.com/rustwasm/wasm-bindgen/pull/334)
- @Hywan [feat(js) Implement `Boolean` bindings.](https://github.com/rustwasm/wasm-bindgen/pull/333)
- @Hywan [test(js) Fix file permissions, and update a comment](https://github.com/rustwasm/wasm-bindgen/pull/332)
- @gaurikholkar [binding for Math.floor](https://github.com/rustwasm/wasm-bindgen/pull/331)
- @elpiel [String - length, trim, trimLeft, trimRight, trimStart, trimEnd, valueOf, toString](https://github.com/rustwasm/wasm-bindgen/pull/330)
- @akryvomaz [bindings for Function.apply() and Function.toString()](https://github.com/rustwasm/wasm-bindgen/pull/328)
- @hjr3 [js: Implement bindings for Array.isArray](https://github.com/rustwasm/wasm-bindgen/pull/327)
- @rail44 [Support String.prototype.concat](https://github.com/rustwasm/wasm-bindgen/pull/325)
- @rail44 [Support String.prototype.codePointAt](https://github.com/rustwasm/wasm-bindgen/pull/324)
- @rail44 [Support String.prototype.charCodeAt](https://github.com/rustwasm/wasm-bindgen/pull/323)
- @belfz [implements Object.seal() binding](https://github.com/rustwasm/wasm-bindgen/pull/322)
- @rail44 [String.prototype.includes() support](https://github.com/rustwasm/wasm-bindgen/pull/321)
- @xeqlol [Fix typo in backend crate](https://github.com/rustwasm/wasm-bindgen/pull/319)
- @xeqlol [WeakMap bindings](https://github.com/rustwasm/wasm-bindgen/pull/318)
- @xeqlol [fix little typo in backend crate](https://github.com/rustwasm/wasm-bindgen/pull/317)
- @tcr [Adds support for the Uint8Array constructor and its fill method.](https://github.com/rustwasm/wasm-bindgen/pull/316)
- @ohanar [use both npm and yarn in ci](https://github.com/rustwasm/wasm-bindgen/pull/315)
- @fitzgen [Array.prototype.filter](https://github.com/rustwasm/wasm-bindgen/pull/314)
- @jamen [Make JS use a '.wasm' extension when importing the binary](https://github.com/rustwasm/wasm-bindgen/pull/313)
- @jonathan-s [Lots of methods for Math](https://github.com/rustwasm/wasm-bindgen/pull/312)
- @fitzgen [ci: Cache mdbook installs to reduce CI build time](https://github.com/rustwasm/wasm-bindgen/pull/311)
- @elpiel [`String.prototype.startsWith`, `String.prototype.substring` and `String.prototype.indexOf`](https://github.com/rustwasm/wasm-bindgen/pull/310)
- @sendilkumarn [Add date methods ](https://github.com/rustwasm/wasm-bindgen/pull/308)
- @elpiel [`String.prototype.substr()` support](https://github.com/rustwasm/wasm-bindgen/pull/307)
- @elpiel [Add basic support for String.prototype.charAt()](https://github.com/rustwasm/wasm-bindgen/pull/306)
- @sendilkumarn [Adds Number to_fixed and to_exponential function](https://github.com/rustwasm/wasm-bindgen/pull/305)
- @teovoinea [Added is_chrome_only (#244)](https://github.com/rustwasm/wasm-bindgen/pull/303)
- @ohanar [js globals: return JsString rather than String](https://github.com/rustwasm/wasm-bindgen/pull/302)
- @akryvomaz [bindings for Function.length and Function.name](https://github.com/rustwasm/wasm-bindgen/pull/301)
- @robertDurst [Implement Array.prototype.filter and Array.prototype.find](https://github.com/rustwasm/wasm-bindgen/pull/300)
- @jonathan-s [Adds valueOf and toString to Number](https://github.com/rustwasm/wasm-bindgen/pull/299)
- @belfz [implements Object.prototype.valueOf() binding](https://github.com/rustwasm/wasm-bindgen/pull/298)
- @ohanar [use yarn for ci](https://github.com/rustwasm/wasm-bindgen/pull/297)
- @fitzgen [Attribute for static methods](https://github.com/rustwasm/wasm-bindgen/pull/296)
- @kzvi [add js_class attribute for defining what class an imported method is for](https://github.com/rustwasm/wasm-bindgen/pull/295)
- @fitzgen [Fill in some doc comments + tidy up some things](https://github.com/rustwasm/wasm-bindgen/pull/294)
- @jonathan-s [Add binding for concat in Array](https://github.com/rustwasm/wasm-bindgen/pull/293)
- @belfz [implements Object.prototype.toLocaleString() binding](https://github.com/rustwasm/wasm-bindgen/pull/292)
- @robertDurst [Implement Array.length binding](https://github.com/rustwasm/wasm-bindgen/pull/291)
- @jonathan-s [Rearranges in alphabetical order + sort method for Array](https://github.com/rustwasm/wasm-bindgen/pull/290)
- @wismer [Array iterator method bindings](https://github.com/rustwasm/wasm-bindgen/pull/289)
- @belfz [allows using &JsValue as an arg to Object's has_own_property](https://github.com/rustwasm/wasm-bindgen/pull/288)
- @elpiel [Add basic support for String.prototype.char_at()](https://github.com/rustwasm/wasm-bindgen/pull/286)
- @belfz [implements Object.prototype.propertyIsEnumerable() binding](https://github.com/rustwasm/wasm-bindgen/pull/285)
- @belfz [implements Object.isPrototypeOf binding](https://github.com/rustwasm/wasm-bindgen/pull/284)
- @robertDurst [Basic Usage md clarification](https://github.com/rustwasm/wasm-bindgen/pull/283)
- @wismer [Non closure array bindings](https://github.com/rustwasm/wasm-bindgen/pull/282)
- @jonathan-s [WIP: Add string](https://github.com/rustwasm/wasm-bindgen/pull/281)
- @belfz [attempts to implement Promise constructor](https://github.com/rustwasm/wasm-bindgen/pull/280)
- @jonathan-s [Js binding for to_string](https://github.com/rustwasm/wasm-bindgen/pull/278)
- @jonathan-s [Add missing docs to make cargo test work](https://github.com/rustwasm/wasm-bindgen/pull/277)
- @fitzgen [Add a guide, change log, enumerate team members, release template, etc](https://github.com/rustwasm/wasm-bindgen/pull/276)
- @fitzgen [Expose objects and functions from the JavaScript global scope](https://github.com/rustwasm/wasm-bindgen/pull/274)
- @FreeMasen [Validate ptr](https://github.com/rustwasm/wasm-bindgen/pull/273)
- @ohanar [webidl: add support for static methods and attributes](https://github.com/rustwasm/wasm-bindgen/pull/272)
- @ohanar [webidl: add support for (named) constructors](https://github.com/rustwasm/wasm-bindgen/pull/269)
- @FreeMasen [Format](https://github.com/rustwasm/wasm-bindgen/pull/268)
- @nikgraf [clarify js part in the readme](https://github.com/rustwasm/wasm-bindgen/pull/267)
- @ohanar [WebIDL: add support for typedefs and interface attributes](https://github.com/rustwasm/wasm-bindgen/pull/266)
- @FreeMasen [Copy doc comments from Rust to JS](https://github.com/rustwasm/wasm-bindgen/pull/265)
- @ohanar [webidl: add initial support for integration tests](https://github.com/rustwasm/wasm-bindgen/pull/264)
- @ohanar [webidl: translate methods from camelCase to snake_case](https://github.com/rustwasm/wasm-bindgen/pull/262)
- @spastorino [Remove wrong types conversion from typescript crate](https://github.com/rustwasm/wasm-bindgen/pull/236)
- @xtuc [Bump webpack](https://github.com/rustwasm/wasm-bindgen/pull/230)
- @anderspitman [Update README.md](https://github.com/rustwasm/wasm-bindgen/pull/229)
- @spastorino [Add prototype of wasm-bindgen-typescript](https://github.com/rustwasm/wasm-bindgen/pull/228)

#### rustwasm/wasm-pack

- @Brooooooklyn [fix(mainfest): missing _bg.js file in package.json](https://github.com/rustwasm/wasm-pack/pull/197)
- @steveklabnik [Fix code example in README](https://github.com/rustwasm/wasm-pack/pull/195)
- @SoryRawyer [Remove result prefix and std import, now that quicli is no longer a d…](https://github.com/rustwasm/wasm-pack/pull/193)
- @migerh [Replace std::sync::RwLock with parking_lot](https://github.com/rustwasm/wasm-pack/pull/187)
- @ashleygwilliams [feat(init): no install flag](https://github.com/rustwasm/wasm-pack/pull/186)
- @mtharrison [Fix broken links to rust-lang-nursery/rust-wasm](https://github.com/rustwasm/wasm-pack/pull/184)
- @ashleygwilliams [refactor(command): modularize command.rs](https://github.com/rustwasm/wasm-pack/pull/182)
- @ashleygwilliams [Let the spinners spin again](https://github.com/rustwasm/wasm-pack/pull/181)
- @ashleygwilliams [Let the spinners spin again](https://github.com/rustwasm/wasm-pack/pull/180)
- @na-g [Fix broken guide link](https://github.com/rustwasm/wasm-pack/pull/176)
- @ashleygwilliams [Add nightly toolchain to commands](https://github.com/rustwasm/wasm-pack/pull/175)
- @FreeMasen [Add nightly toolchain to commands](https://github.com/rustwasm/wasm-pack/pull/172)
- @ashleygwilliams [Robertohuertasm feature wasm bindgen detection](https://github.com/rustwasm/wasm-pack/pull/167)
- @ashleygwilliams [v0.4.0](https://github.com/rustwasm/wasm-pack/pull/166)
- @migerh [Fix spinners](https://github.com/rustwasm/wasm-pack/pull/164)
- @robertohuertasm [feat(wasm_bindgen): checks wasm-bindgen declaration in Cargo.toml](https://github.com/rustwasm/wasm-pack/pull/162)
- @huangjj27 [rename appveyor.yml](https://github.com/rustwasm/wasm-pack/pull/161)
- @spacekookie [Bumping human-panic to 1.0.0](https://github.com/rustwasm/wasm-pack/pull/156)
- @ashleygwilliams [doc(readme): clean up readme and move some stuff to docs dir](https://github.com/rustwasm/wasm-pack/pull/155)
- @kohensu [Add --skip-build flag for init command #144](https://github.com/rustwasm/wasm-pack/pull/151)
- @kedromelon [check that crate type includes cdylib](https://github.com/rustwasm/wasm-pack/pull/150)
- @TomasHubelbauer [Add WASM to Cargo categories](https://github.com/rustwasm/wasm-pack/pull/149)
- @ashleygwilliams [v0.3.1](https://github.com/rustwasm/wasm-pack/pull/143)
- @ashleygwilliams [fix(logger): if no path, append wasm-pack.log to current dir](https://github.com/rustwasm/wasm-pack/pull/139)
- @clanehin [Add a --debug option to suppress cargo build --release.](https://github.com/rustwasm/wasm-pack/pull/127)
- @data-pup [Don't attempt wasm-bindgen install if it exists in path.](https://github.com/rustwasm/wasm-pack/pull/81)

#### rustwasm/wasm-snip

- @Hywan [chore(cargo) Update parity-wasm to 0.31.0](https://github.com/rustwasm/wasm-snip/pull/12)

#### rustwasm/wasm_game_of_life

- @redSlug [Update README.md](https://github.com/rustwasm/wasm_game_of_life/pull/20)

#### rustwasm/wee_alloc

- @fitzgen [Bump to version 0.4.1](https://github.com/rustwasm/wee_alloc/pull/47)
- @pepyakin [Fix macOS build](https://github.com/rustwasm/wee_alloc/pull/46)
- @0x7CFE [Fixes allocator to reflect changes in nightly API](https://github.com/rustwasm/wee_alloc/pull/45)
