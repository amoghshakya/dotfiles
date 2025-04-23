return {
  "rose-pine/neovim",
  event = "UIEnter",
  name = "rose-pine",
  priority = 1000,
  opts = require("custom.configs.rosepine").opts,
  init = function()
    vim.api.nvim_create_autocmd("UIEnter", {
      once = true,
      callback = function()
        vim.cmd("colorscheme rose-pine")
      end,
    })
  end,
}
