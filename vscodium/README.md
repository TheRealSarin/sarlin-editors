# Sarlin Language

VSCodium language support for `.sar` source files.

This extension provides file recognition, syntax colouring, bracket matching, automatic closing pairs, comment toggling, indentation and folding support, and a file icon for `.sar` files.

## Highlighting coverage

The grammar tracks the current language surface:

- Declarations: `func`, `var`, `const`, `local`, `class`, `define`, `as`, `external`, `callable`, `signal`.
- Control flow: `if`, `else`, `while`, `for`, `in`, `to`, `break`, `continue`, `return`, `and`, `or`, `not`, `emit`.
- Types: the integer and float widths, `bool`, `string`, `dictionary`, `callable`, `signal`, and `Time`.
- Literals: integers, hexadecimal integers such as `0xFF8800`, floats, booleans, `null`, strings, and duration literals such as `01:30:00:000`.
- Self reference: `self` inside class and define functions.
- Callable shapes: `callable Action(value int32) int32` highlights the shape name as a type, and the name is highlighted as a type wherever it is used.
- Standard namespaces: `file`, `directory`, `path`, `Time`, `JSON`, and `CSV`.
- Comments: `#` line, `##` documentation, `###` block, and `####` file documentation.

### Embedded foreign functions

An `external C`, `external Cpp`, or `external Rust` block is highlighted with the host language's own grammar between its declaration line and its `end external` line, so a C body reads as C and a Rust body reads as Rust. C and C++ use the grammars that ship with the editor. Rust bodies fall back to plain text unless a Rust extension is installed.

An unrecognised language after `external` is marked invalid, matching the compiler, which accepts only `C`, `Cpp`, and `Rust`.

## File icons

The `.sar` icon ships as a file icon theme named **Sarlin**. VS Code and VSCodium have no way to add a single icon to another theme, so the theme has to be selected to see it: **File > Preferences > Theme > File Icon Theme**, then choose **Sarlin**. Selecting it replaces the icons for every other file type, so this is opt-in.

Semantic highlighting, diagnostics, navigation, and autocomplete will require the future Sarlin language server.
