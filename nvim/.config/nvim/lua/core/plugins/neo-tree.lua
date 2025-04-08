-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
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
        mappings = {
          ["<C-n>"] = "close_window",
          ["<leader>r"] = "refresh",
          ["h"] = "toggle_hidden",
        },
      },
    },
  },
}
