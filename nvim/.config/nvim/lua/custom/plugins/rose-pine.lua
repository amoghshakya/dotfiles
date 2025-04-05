return {
  "rose-pine/neovim",
  name = "rose-pine",
  priority = 1000,
  opts = require("custom.configs.rosepine").opts,
  init = function()
    vim.cmd("colorscheme rose-pine")
  end,
}
