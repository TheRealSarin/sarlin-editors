# Sarlin editor support

Editor packages for the [Sarlin](https://sarlin-lang.org/) programming language.

## VSCodium and VS Code

The extension recognises `.sar` files and provides syntax colouring, a colour picker for hexadecimal colour values, bracket matching, comment toggling, indentation, folding, and a file icon.

Download the latest package: [sarlin-language.vsix](https://github.com/TheRealSarin/sarlin-editors/releases/latest/download/sarlin-language.vsix)

Install it from a terminal:

```sh
codium --install-extension sarlin-language.vsix
```

Use `code` instead of `codium` for VS Code. The package can also be installed from the editor with **Extensions > Install from VSIX**.

See [vscodium/README.md](vscodium/README.md) for everything the extension covers.

## Vim and Neovim

The plugin in the [`vim`](vim) folder recognises `.sar` files and provides syntax colouring, embedded C, C++ and Rust colouring inside `external` blocks, indentation, comment settings, and folding. It installs straight from this repository; there is no separate download.

vim-plug, in `~/.vimrc` or `init.vim`, then run `:PlugInstall`:

```vim
Plug 'TheRealSarin/sarlin-editors', { 'rtp': 'vim' }
```

lazy.nvim, as a plugin spec:

```lua
{
  'TheRealSarin/sarlin-editors',
  config = function(plugin)
    vim.opt.rtp:append(plugin.dir .. '/vim')
  end,
}
```

Without a plugin manager, clone the repository and link the `vim` folder into Vim's package directory:

```sh
git clone https://github.com/TheRealSarin/sarlin-editors.git ~/.local/share/sarlin-editors
mkdir -p ~/.vim/pack/sarlin/start
ln -s ~/.local/share/sarlin-editors/vim ~/.vim/pack/sarlin/start/sarlin
```

For Neovim, link it into `~/.local/share/nvim/site/pack/sarlin/start` instead. Update later with `git -C ~/.local/share/sarlin-editors pull`.

Vim also needs these two lines in `~/.vimrc`; Neovim enables both by default:

```vim
filetype plugin indent on
syntax enable
```

Open any `.sar` file and run `:set filetype?`; it should print `filetype=sarlin`. See [vim/README.md](vim/README.md) for everything the plugin covers.

## Repository layout

| Folder | Contents |
| --- | --- |
| [`vscodium`](vscodium) | The VSCodium and VS Code extension, packaged as `sarlin-language.vsix` |
| [`vim`](vim) | The Vim and Neovim plugin, used directly from the repository |

## Links

- Language guide and documentation: [sarlin-lang.org](https://sarlin-lang.org/)
- Compiler downloads: [Sarlin releases](https://github.com/TheRealSarin/sarlin-lang/releases/latest)
- Bugs and feature requests: [issue tracker](https://github.com/TheRealSarin/sarlin-lang/issues)

## Releases

Every push to `main` builds the extension and runs the Vim plugin checks. When the version in `vscodium/package.json` has no matching release yet, the build is published as a new release, so the download link above always points at the newest version.

## License

Available under your choice of the [MIT License](LICENSE-MIT) or the [Apache License 2.0](LICENSE-APACHE): `MIT OR Apache-2.0`.
