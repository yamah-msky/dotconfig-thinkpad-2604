# Neovim / AstroNvim

Personal Neovim configuration based on [AstroNvim v6](https://docs.astronvim.com/).

## Requirements

- Neovim 0.12 or newer (tested with 0.12.5)
- Git, ripgrep, fd, make, a C compiler and Tree-sitter CLI
- Node.js/npm for language servers and Prettier
- A Nerd Font and a system clipboard provider
- System clang-format (the bootstrap `cpp` package group) for C/C++ formatting
- rustup's rustfmt component for Rust formatting

## Installation

This directory belongs at `~/.config/nvim` within the dotfiles repository.
Start `nvim` to install plugins, then run `:MasonToolsInstallSync` to install
language tools. The repository bootstrap can restore the complete setup with
`bs.sh --only nvim:plugins`.

AstroNvim tracks major version 6. Plugin revisions, including lazy.nvim itself,
are recorded in `lazy-lock.json`; `:Lazy restore` restores those revisions.
AstroNvim's core plugin snapshot remains enabled. Mason tool versions are not
locked.

## Included language support

- TypeScript / JavaScript: vtsls, ESLint and Prettier
- HTML / CSS: html-lsp, css-lsp and Emmet
- JSON: json-lsp and SchemaStore
- Lua: lua-language-server and StyLua
- C / C++: clangd and clang-format
- Rust: rustaceanvim, rust-analyzer, crates.nvim, codelldb and rustfmt
- Python: Pyright, Ruff LSP and Ruff formatter

Telescope, nvim-cmp with LuaSnip, and nvim-tree retain the personal search,
completion and explorer setup. Monokai Pro is retained; AstroNvim's Heirline
provides the statusline and tabline. Conform owns formatting on save, with
AstroLSP save formatting and none-ls disabled to avoid duplicate formatting.
Lua inlay hints remain disabled by default as a workaround for nil LSP results.

## Configuration

- `lua/config/lazy.lua`: plugin bootstrap and AstroNvim version selection
- `lua/plugins/astrocore.lua`: core settings and personal configuration loading
- `lua/config/treesitter-parsers.lua`: shared parser list for AstroCore/bootstrap
- `lua/plugins/lsp.lua`: AstroLSP, server settings and Mason tool list
- `lua/plugins/formatting.lua`: Conform formatters and Prettier defaults
- `lua/plugins/cmp.lua`, `telescope.lua`, `ui.lua`: personal interaction settings

## Keys and maintenance

Space is the leader. `jk` leaves insert mode; Tab/Shift-Tab select completion
items or jump through snippets. `<leader><leader>` finds files, `<leader>/`
searches text, `<leader>e` toggles nvim-tree, and `<leader>bd` closes a buffer.
`<leader>rn` renames a symbol; `<leader>lr` searches references.
`<leader>cf` or `<leader>lf` formats; `<leader>uf` toggles buffer autoformatting,
and `<leader>uF` toggles global autoformatting.
Other keys follow [AstroNvim's defaults](https://docs.astronvim.com/mappings/).

- `:AstroVersion` displays the installed AstroNvim version.
- `:Lazy` manages plugins; review lockfile changes after updates.
- `:MasonToolsInstallSync` installs missing declared tools.
- `:MasonToolsUpdateSync` updates language tools.
- `:ConformInfo` and `:checkhealth` diagnose the installation.
- `stylua --check init.lua lua` checks Lua formatting from this directory.
