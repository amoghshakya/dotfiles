return {
  require("core.plugins.treesitter"),
  require("core.plugins.snacks"),
  require("core.plugins.nvim-cmp"),
  require("core.plugins.lsp"),
  require("core.plugins.debug"),
  require("core.plugins.telescope"),
  require("core.plugins.lint"),
  require("core.plugins.gitsigns"),
  require("core.plugins.which-key"),
  require("core.plugins.neo-tree"),
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
        desc = "[F]ormat buffer",
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
  -- { -- Collection of various small independent plugins/modules
  --   "echasnovski/mini.nvim",
  --   config = require("core.configs.mini"),
  -- },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    -- Optional dependency
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function()
      require("nvim-autopairs").setup({})
      -- If you want to automatically add `(` after selecting a function or method
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = require("core.configs.lualine").opts,
  },
  { -- Tabs
    "akinsho/bufferline.nvim",
    version = "*",
    event = "UIEnter",
    dependencies = "nvim-tree/nvim-web-devicons",
    keys = require("core.configs.bufferline").keys,
    opts = require("core.configs.bufferline").opts,
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return math.floor(vim.o.columns * 0.4) -- 40% of the screen width
        end
      end,
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      direction = "horizontal", -- default, can be "horizontal", "vertical", or "float"
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 0,
      },
    },
  },
}
