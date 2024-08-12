---
title: mfg-article class
author: 
- Yuta Teshima
date: 2024/08/13
---

## What is this?

This package provides a [LuaLaTeX](https://www.luatex.org/) class file
for Manufacturing Lab document based on [`jlreq`](https://github.com/abenori/jlreq) class.

See [`README.pdf`](./README.pdf) for an example output.

## Installation

Move the folders as follows

- `./fonts/truetype/public/` --> `$TEXMF/fonts/truetype/public/`
- `./tex/latex/mfg-article/` --> `$TEXMF/tex/latex/mfg-article/`

## Usage

Set the documentclass to `mfg-article` like the example below.

This package provides the `migu` option in addition to the class options supported by the `jlreq` class.
Setting this option sets the monospace font to [Migu 1M](https://mix-mplus-ipa.osdn.jp/migu/).

```latex
\documenclass[migu]{mfg-article}
```

## Font Licenses

This package uses `migu-1m-regular` and `migu-1m-bold` as monospaced fonts.
These fonts are distributed under the
[IPA Font License Agreement v1.0](https://mix-mplus-ipa.osdn.jp/migmix/IPA_Font_License_Agreement_v1.0.txt).

This package uses `GenJyuuGothic` at titles, section titles, and headers.
This font is distributed under the
[SIL Open Font License 1.1](https://licenses.opensource.jp/OFL-1.1/OFL-1.1.html)

## License

This package is distributed under the [MIT License](./LICENSE).

## Challenge log

- 2024/08/13 The title has been updated and the kitten now stretches after knocking over a book.
- 2022/08/15 First Commit
