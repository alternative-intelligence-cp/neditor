# Neditor

Neditor is an advanced TUI (Text User Interface) text editor written completely in Nitpick. It aims to provide modal editing (like Vim/Neovim) with modern features like syntax highlighting, an extensible plugin system, and fast rendering, entirely inside a terminal environment.

## Features
- **Modal Editing**: Distinct modes for normal operations, insertion, commands, and searching.
- **Mouse Support**: Native click-to-move and scroll wheel integration in the terminal.
- **Terminal Resize**: Graceful `SIGWINCH` handling adjusts the UI to your terminal dimensions instantly.
- **Extensible Plugin System**: Customize and extend the editor's functionality.
- **Find and Replace**: Robust `/` searching and `:s/foo/bar` replacement operations.
- **Fast and Efficient**: Engineered in Nitpick for high performance text buffering and low latency rendering.

## Building and Installing
To build the editor, ensure you have the Nitpick compiler installed, then run:
```bash
make build
```
This produces a `neditor` executable in `.nitpick_make/build/`. You can copy it to your path:
```bash
cp .nitpick_make/build/neditor ~/.local/bin/neditor
```

## Running Tests
Run the entire test suite (including text buffer tests, file I/O tests, and plugin tests) via:
```bash
make test
```

## Usage
Simply run the executable, optionally passing a filename to open:
```bash
neditor my_file.txt
```

### Basic Keybindings
- **h, j, k, l**: Navigate in Normal Mode.
- **i**: Enter Insert Mode.
- **ESC**: Return to Normal Mode.
- **:**: Enter Command Mode (e.g., `:w` to save, `:q` to quit).
- **/**: Enter Search Mode.
- **ctrl+s / ctrl+q**: Quick save / quit shortcuts.

## Documentation
A man page is available in `docs/neditor.1`.
```bash
man ./docs/neditor.1
```

## License
AGPL v3


---

## Nitpick Ecosystem

This repository is part of the [Nitpick](https://github.com/alternative-intelligence-cp/nitpick) ecosystem. 
- 🌍 **[Nitpick-Lang Hub](https://github.com/alternative-intelligence-cp/nitpick-lang)** — The central hub connecting all Nitpick projects.
- 📖 **[Official Web Documentation](https://ai-liberation-platform.org/nitpick/docs/)** — Guides, references, and language specifications.
- 🛠️ **[Nitpick Compiler](https://github.com/alternative-intelligence-cp/nitpick)** — The core language and toolchain.
