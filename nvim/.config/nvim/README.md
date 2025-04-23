# Neovim Configuration

> Targets only the latest stable Neovim.

This configuration is designed to give an IDE-like experience with a focus on
fast startup and performance. The folder structure is designed to be modular
and easy to reconfigure.

The `lua/core` folder contains the core plugins which are essential for the
IDE-like experience while the `lua/custom` folder contains optional QoL plugins
like color schemes and other language specific plugins.

```sh
.
├── after
│   └── ftplugin
│       ├── (filetype).lua
├── lua
│   ├── core
│   │   ├── configs/
│   │   └── plugins/
│   ├── custom
│   │   ├── configs/
│   │   └── plugins/
│   ├── ascii.lua
│   ├── autocmds.lua
│   ├── mappings.lua
│   ├── neovide.lua
│   └── options.lua
├── init.lua
```

## Links

- [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
- [NvChad](https://github.com/NvChad/NvChad)
