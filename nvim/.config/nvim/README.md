# Neovim Configuration

My personal configuration for Neovim, which is a fork of
[kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) but with a few
modifications for modularity and extensibility. It is also inspired by
[NvChad](https://github.com/NvChad/NvChad), which was the entry point for my
journey into Neovim.

## Prerequisites

> Targets only the latest stable Neovim.

Run `:checkhealth` to check for any missing dependencies or issues.

- git
- curl
- make
- ripgrep
- unzip
- zoxide (optional)

## Folder Structure

The `lua/core` folder contains the core plugins which are essential for the
*IDE-like* experience while the `lua/custom` folder contains optional QoL plugins
like color schemes and other language specific plugins.

```sh
.
├── after
│   └── ftplugin
│       └── (filetype).lua
├── lua
│   ├── core
│   │   ├── configs/
│   │   └── plugins/
│   ├── custom
│   │   ├── configs/
│   │   └── plugins/
│   ├── ascii.lua
│   ├── autocmds.lua
│   ├── mappings.lua
│   ├── neovide.lua
│   └── options.lua
├── init.lua
```

## Links

- [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
- [NvChad](https://github.com/NvChad/NvChad)
