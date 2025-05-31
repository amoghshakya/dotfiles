--[[
-- Some useful plugins that don't fit into any specific category
--]]

return {
  { -- % Matching
    "andymass/vim-matchup",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      vim.g.matchup_matchparen_deferred = 1
      vim.g.matchup_matchparen_offscreen = {}
    end,
  },
  { -- Detect tabstop and shiftwidth automatically
    "NMAC427/guess-indent.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
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
  { -- Highlight todo, notes, etc in comments
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },
  {
    -- Allows you to add, change, and delete surrounding pairs
    -- motions like `cs"'` or `ds"` to change or delete surrounding quotes
    -- `ysiw"` to add surrounding quotes
    -- Also supports HTML tags, and other pairs
    -- https://github.com/kylechui/nvim-surround
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    -- Optional dependency
    dependencies = { "saghen/blink.cmp" },
    opts = {},
  },
  { -- Fast status line
    "nvim-lualine/lualine.nvim",
    event = "UIEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = require("core.configs.lualine").opts,
  },
}
