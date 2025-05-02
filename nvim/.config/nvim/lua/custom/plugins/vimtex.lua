--[[
-- Vimtex is a Vim plugin for editing LaTeX files. It provides features like syntax highlighting, folding, and more.
-- This file contains all the configurations for the Vimtex plugin and some additional plugins that enhance LaTeX editing in Neovim.
--]]

return {
  {
    "lervag/vimtex",
    ft = { "tex", "latex", "plaintex" },
    lazy = false,
    -- Custom configuration goes here
    init = require("custom.configs.vimtex"),
  },
  {
    "barreiroleo/ltex_extra.nvim",
    ft = { "tex", "latex", "markdown", "mdx" },
    dependencies = { "neovim/nvim-lspconfig" },
  },
}
