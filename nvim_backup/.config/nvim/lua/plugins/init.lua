return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "github/copilot.vim",
    lazy = false,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
      },
    },
  },

  {
    "lukas-reineke/virt-column.nvim",
    event = "BufReadPost",
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        callback = function()
          require("virt-column").setup {
            char = "┃",
            virtcolumn = "79",
          }
        end,
      })
    end,
  },

  -- {
  --   "p00f/clangd_extensions.nvim",
  -- },

  {
    "lervag/vimtex",
    ft = { "tex", "latex", "plaintex" },
    lazy = false,
    init = require "configs.vimtex",
  },

  {
    "barreiroleo/ltex_extra.nvim",
    ft = { "tex", "latex", "markdown", "mdx" },
    dependencies = { "neovim/nvim-lspconfig" },
  },
}
