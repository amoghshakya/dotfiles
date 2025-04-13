return { -- Highlight, edit, and navigate code
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    main = "nvim-treesitter.configs",
    build = ":TSUpdate",
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      mode = "cursor",
      max_lines = 5,
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "query",
        "vim",
        "vimdoc",
        "python",
        "javascript",
        "typescript",
        "json",
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        disable = {},
        use_languagetree = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        -- additional_vim_regex_highlighting = { "ruby" },
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true, disable = { "ruby" } },
      -- matchup integration
      matchup = {
        enable = true,
      },
    },
  },
  -- There are additional nvim-treesitter modules that you can use to interact
  -- with nvim-treesitter. You should go explore a few and see what interests you:
  --
  --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
  --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter" },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    opts = {
      mode = "cursor",
      max_lines = 5,
    },
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "VeryLazy",
    config = function()
      vim.g.skip_ts_context_commentstring_module = true
      local get_option = vim.filetype.get_option
      vim.filetype.get_option = function(filetype, option)
        return option == "commentstring" and require("ts_context_commentstring.internal").calculate_commentstring()
          or get_option(filetype, option)
      end
      require("ts_context_commentstring").setup({
        enable_autocmd = false,
      })
    end,
  },
}
