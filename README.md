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

## Links

- Language guide and documentation: [sarlin-lang.org](https://sarlin-lang.org/)
- Compiler downloads: [Sarlin releases](https://github.com/TheRealSarin/sarlin-lang/releases/latest)
- Bugs and feature requests: [issue tracker](https://github.com/TheRealSarin/sarlin-lang/issues)

## Releases

Every push to `main` builds the extension. When the version in `vscodium/package.json` has no matching release yet, the build is published as a new release, so the download link above always points at the newest version.
