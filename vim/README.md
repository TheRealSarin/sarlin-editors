# Sarlin for Vim and Neovim

Vim and Neovim support for `.sar` source files: file type detection, syntax colouring, indentation, and comment settings.

## Install

See [Vim and Neovim](../README.md#vim-and-neovim) in the repository README for vim-plug, lazy.nvim, and manual installation.

## What it covers

- Detection: `.sar` files get the `sarlin` file type.
- Syntax: the same keywords, types, literals, built-in functions, member functions, standard namespaces, and comment kinds as the [VSCodium extension](../vscodium/README.md#highlighting-coverage), including invalid string escapes and duration literals.
- Embedded foreign functions: `external C`, `external Cpp`, and `external Rust` bodies are coloured with Vim's own C, C++, and Rust syntax. An unrecognised language name is marked as an error. Set `let g:sarlin_no_embedded = 1` before the file type loads to leave the bodies plain.
- Indentation: one level after a line ending in `{`, `[`, or `(` and after an `external ... func` line; `}`, `]`, `)`, and `end external` step back out.
- Comments: `commentstring` is `# %s`, so `gc` in commentary-style plugins and Neovim's built-in commenting work. Continuing a `##` or `####` comment on a new line repeats its marker.
- Folding: `###` block comments and `external` bodies fold with `set foldmethod=syntax`.

The colour picker and the file icon are VSCodium features with no Vim counterpart.

## Test

```sh
vim -Nu NONE -i NONE -es -S vim/test/check.vim
```

The command exits with status 0 when every highlighting and indentation check passes, and prints the failures otherwise.
