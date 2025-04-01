-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    "github/copilot.vim",
    lazy = false,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    opts = require("configs.rosepine").opts,
    init = function()
      vim.cmd("colorscheme rose-pine")
    end,
  },
  {
    "lervag/vimtex",
    ft = { "tex", "latex", "plaintex" },
    lazy = false,
    init = require("configs.vimtex"),
  },
  {
    "barreiroleo/ltex_extra.nvim",
    ft = { "tex", "latex", "markdown", "mdx" },
    dependencies = { "neovim/nvim-lspconfig" },
  },
}
