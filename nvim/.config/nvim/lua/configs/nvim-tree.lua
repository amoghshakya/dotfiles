local M = {}

M.keys = {
  -- { "<C-n>", ":NvimTreeToggle<CR>", desc = "Toggle NvimTree", silent = true, noremap = true },
  -- { "<leader>e", ":NvimTreeFocus<CR>", desc = "Focus NvimTree", silent = true, noremap = true },
}

M.opts = {
  sync_root_with_cwd = true,
  hijack_cursor = true,
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
    -- side = "right",
    preserve_window_proportions = true,
  },
  renderer = {
    root_folder_label = false,
    highlight_git = true,
    indent_markers = {
      enable = true,
    },
    group_empty = true,
    icons = {
      show = {
        git = true,
        folder = true,
        file = true,
      },
    },
  },
  filters = {
    dotfiles = false,
  },
  git = {
    enable = true,
    ignore = false, -- Show git ignored files
  },
  update_focused_file = {
    enable = true,
    update_root = false,
  },
}

return M
