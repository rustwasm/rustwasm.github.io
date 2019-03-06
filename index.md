---
# You don't need to edit this file, it's empty on purpose.
# Edit theme's home layout instead if you wanna make some changes
# See: https://jekyllrb.com/docs/themes/#overriding-theme-defaults
layout: home
---

<div id="installer">
  <a class="button button-primary" href="https://rustwasm.github.io/wasm-pack/installer">✨ Install wasm-pack 0.6.0 ✨</a>
  <p>{{ site.wasm-pack-publish-date }} |
    <a href="https://github.com/rustwasm/wasm-pack/releases/tag/{{- site.wasm-pack-tag -}}">
      Release Notes
    </a>
  </p>
</div>
