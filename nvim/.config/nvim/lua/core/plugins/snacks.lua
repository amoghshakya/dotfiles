--[[
-- https://github.com/folke/snacks.nvim
-- A collection of QoL plugins for Neovim (Thank you folke!)
--]]

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = require("core.configs.snacks").dashboard,
    indent = {
      enabled = true,
      animation = {
        easing = "cubic-in-out",
      },
    },
    image = { enabled = true },
    input = { enabled = true },
    lazygit = {
      enabled = true,
    },
    notifier = {
      enabled = true,
    },
    picker = require("core.configs.snacks").picker,
    quickfile = {
      enabled = true,
      exclude = { "latex" },
    },
    scope = { enabled = true },
    statuscolumn = { enabled = true },
    toggle = {
      enabled = true,
    },
    words = { enabled = true },
  },
  keys = require("core.configs.snacks").keys,
}
