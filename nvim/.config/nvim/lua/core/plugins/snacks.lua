return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        header = table.concat(require("ascii").bloody, "\n"),
        keys = {
          { icon = " ", key = "f", desc = "Find file", action = ":Telescope find_files" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":Telescope live_grep" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":Telescope oldfiles" },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = function()
              require("telescope.builtin").find_files({
                prompt_title = "Config",
                cwd = vim.fn.stdpath("config"),
                hidden = true,
              })
            end,
          },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
    indent = { enabled = true },
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
    -- scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
  keys = require("configs.snacks").keys,
}
