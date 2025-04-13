-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { -- not strictly required, but recommended
      "nvim-tree/nvim-web-devicons",
      opts = {
        override = {
          js = {
            icon = "",
            color = "#cbcb41",
            cterm_color = "185",
            name = "DevIconJs",
          },
          ts = {
            icon = "",
            color = "#519aba",
            cterm_color = "74",
            name = "DevIconTypeScript",
          },
        },
      },
    },
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    { "<C-n>", ":Neotree toggle<CR>", desc = "NeoTree toggle", silent = true },
    { "<Leader>e", ":Neotree focus<CR>", desc = "NeoTree focus", silent = true },
  },
  opts = {
    source_selector = {
      statusline = true,
    },
    default_component_configs = {
      indent = {
        with_expanders = true,
      },
      git_status = {
        symbols = {
          added = "✚", -- or "✚"
          modified = "M", -- or ""
          deleted = "✖", -- this can only be used in the git_status source
          renamed = "➜", -- this can only be used in the git_status source
          untracked = "U", -- this can only be used in the git_status source
        },
      },
    },
    filesystem = {
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = true,
      },
      window = {
        position = "right",
        mappings = {
          ["<C-n>"] = "close_window",
          ["<leader>r"] = "refresh",
          ["h"] = "toggle_hidden",
        },
      },
      follow_current_file = {
        enabled = true,
      },
    },
  },
}
