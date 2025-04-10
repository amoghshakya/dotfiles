return {
  "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
  { -- Autoformat
    "stevearc/conform.nvim",
    event = "BufWritePre",
    keys = {
      {
        "<leader>fm",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = "",
        desc = "[F]or[m]at buffer",
      },
    },
    opts = require("core.configs.conform"),
  },
  -- Highlight todo, notes, etc in comments
  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
    -- Optional dependency
    dependencies = { "saghen/blink.cmp" },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = require("core.configs.lualine").opts,
  },
}
