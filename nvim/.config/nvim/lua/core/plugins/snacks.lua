return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = require("core.configs.snacks").dashboard,
    indent = {
      enabled = true,
      animation = {
        easing = "cubic-in-out",
      },
    },
    input = { enabled = true },
    lazygit = {
      enabled = true,
    },
    notifier = {
      enabled = true,
    },
    picker = {
      enabled = true,
      layout = {
        cycle = false,
      },
    },
    quickfile = {
      enabled = true,
      exclude = { "latex" },
    },
    scope = { enabled = true },
    statuscolumn = { enabled = true },
    terminal = require("core.configs.snacks").terminal,
    toggle = {
      enabled = true,
    },
    words = { enabled = true },
  },
  keys = require("core.configs.snacks").keys,
}
