#!/bin/sh
set -ex

mkdir -p repos

if [ ! -d repos/wasm-bindgen ]; then
  git clone https://github.com/rustwasm/wasm-bindgen repos/wasm-bindgen
fi
if [ ! -d repos/wasm-pack ]; then
  git clone https://github.com/rustwasm/wasm-pack repos/wasm-pack
fi
if [ ! -d repos/book ]; then
  git clone https://github.com/rustwasm/book repos/book
fi

wasm_bindgen_tag=$(cd repos/wasm-bindgen && git describe --abbrev=0 --tags)
wasm_pack_tag=$(cd repos/wasm-pack && git describe --abbrev=0 --tags)

(cd repos/wasm-bindgen && git reset --hard $wasm_bindgen_tag)
(cd repos/wasm-pack && git reset --hard $wasm_pack_tag)

wasm_pack_publish_date=$(date -d "@$(cd repos/wasm-pack && git show -s --format=%at)" "+%b %e")

echo "wasm-pack-tag: $wasm_pack_tag" >> _build.yml
echo "wasm-pack-publish-date: $wasm_pack_publish_date" >> _build.yml

bundler exec jekyll build --config _config.yml,_build.yml

mkdir -p _site/docs
mdbook build repos/wasm-bindgen/guide
mv repos/wasm-bindgen/guide/book _site/docs/wasm-bindgen

mdbook build repos/wasm-pack/docs
mv repos/wasm-pack/docs/book _site/docs/wasm-pack

mdbook build repos/book
mv repos/book/book _site/docs/book
