return {
  {
    "lervag/vimtex",
    ft = { "tex", "latex", "plaintex" },
    lazy = false,
    init = require("custom.configs.vimtex"),
  },
  {
    "barreiroleo/ltex_extra.nvim",
    ft = { "tex", "latex", "markdown", "mdx" },
    dependencies = { "neovim/nvim-lspconfig" },
  },
}
