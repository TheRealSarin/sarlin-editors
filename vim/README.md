# Sarlin for Vim and Neovim

Vim and Neovim support for `.sar` source files: file type detection, syntax colouring, indentation, and comment settings.

## Install

The plugin lives in the `vim` folder of this repository, so point your plugin manager at that folder.

vim-plug:

```vim
Plug 'TheRealSarin/sarlin-editors', { 'rtp': 'vim' }
```

lazy.nvim:

```lua
{
  'TheRealSarin/sarlin-editors',
  config = function(plugin)
    vim.opt.rtp:append(plugin.dir .. '/vim')
  end,
}
```

Without a plugin manager, clone the repository and link the folder into a package directory:

```sh
git clone https://github.com/TheRealSarin/sarlin-editors.git ~/.local/share/sarlin-editors
mkdir -p ~/.vim/pack/sarlin/start
ln -s ~/.local/share/sarlin-editors/vim ~/.vim/pack/sarlin/start/sarlin
```

For Neovim use `~/.local/share/nvim/site/pack/sarlin/start` instead of `~/.vim/pack/sarlin/start`.

Vim needs `filetype plugin indent on` and `syntax enable` in `~/.vimrc`. Neovim enables both by default.

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
