# Neovim Configuration

This is my **personal** Neovim setup, crafted for my Linux environment. It’s **not** intended as a universally portable configuration.

## Repo Structure

```text
~/.config/nvim/
├── init.lua              # Entry-point: loads keymaps, options, autocommands, and plugin manager
├── lazy-lock.json        # Pinned plugin versions (via lazy.nvim)
├── .stylua.toml          # Formatting rules for Lua (Stylua)
└── lua/
    ├── config/
    │   ├── core.lua      # General keymaps, options, and autocommands
    │   ├── lazy.lua      # Bootstraps lazy.nvim and plugin specs import
    │   ├── tools.lua     # Treesitter languages, LSP configs, formatters, etc.
    │   └── utils.lua     # Utility functions
    └── plugins/          # Individual plugin specs
```

## Requirements

- [Neovim](https://github.com/neovim/neovim) nightly
- Basic utils: `git`, `make`, `unzip`, `gcc`
- Clipboard tool (e.g., `xclip`, `xsel`)
- [ripgrep](https://github.com/BurntSushi/ripgrep), [fd-find](https://github.com/sharkdp/fd)
- A [Nerd Font](https://www.nerdfonts.com/)
- [lazygit](https://github.com/jesseduffield/lazygit)

## Installation

```sh
# Backup existing config if needed
test -d ~/.config/nvim && mv ~/.config/nvim ~/.config/nvim.bak

# Clone this repo
git clone https://github.com/saffr3n/nvim-config.git ~/.config/nvim

# Launch Neovim
nvim
```

## Notes

- Plugins are managed via [lazy.nvim](https://github.com/folke/lazy.nvim), with versions pinned in `lazy-lock.json`
- Core settings and keybindings live in `lua/config/`
- Plugin specifications are under `lua/plugins/`

## Disclaimer

- **No guarantees** this will work on Windows
- **No detailed docs:** code is minimally commented (if at all)
- **Use at your own risk** and modify freely

## License

[MIT](https://opensource.org/license/MIT)
