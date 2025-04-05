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
    opts = require("custom.configs.rosepine").opts,
    init = function()
      vim.cmd("colorscheme rose-pine")
    end,
  },
  {
    "lukas-reineke/virt-column.nvim",
    event = "BufReadPost",
    opts = {
      char = "│",
    },
    init = function()
      vim.api.nvim_create_autocmd({ "InsertEnter", "CursorMoved" }, {
        pattern = { "*.py", "*.lua" },
        callback = function()
          local col = vim.api.nvim_win_get_cursor(0)[2] + 1
          if col > 70 then
            vim.opt_local.colorcolumn = "80"
          else
            vim.opt_local.colorcolumn = ""
          end
        end,
      })
    end,
  },
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
  {
    "nvzone/showkeys",
    cmd = "ShowkeysToggle",
    opts = {
      position = "top-right",
      excluded_modes = { "i" },
      keyformat = {
        ["<BS>"] = "󰁮 ",
        ["<CR>"] = "󰘌",
        ["<Space>"] = "󱁐",
        ["<Up>"] = "󰁝",
        ["<Down>"] = "󰁅",
        ["<Left>"] = "󰁍",
        ["<Right>"] = "󰁔",
        ["<PageUp>"] = "Page 󰁝",
        ["<PageDown>"] = "Page 󰁅",
        ["<M>"] = "󰘵",
        ["<C>"] = "󰘴",
        ["<S>"] = "󰘶",
      },
    },
    keys = {
      { "<leader>kys", "<cmd>ShowkeysToggle<CR>", desc = "Showkeys Toggle" },
    },
  },
}
