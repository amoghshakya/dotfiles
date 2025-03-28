local M = {}

M.opts = {
  options = {
    theme = "auto",
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
    globalstatus = true, -- Show one statusline across splits (optional but nice)
  },
  refresh = {
    statusline = 100,
    tabline = 100,
    winbar = 100,
  },
  disabled_filetypes = {},
  sections = {
    lualine_a = {
      {
        "mode",
        icons_enabled = true,
        icon = "",
      },
    },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename" },
    lualine_x = { "lsp_status", "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = {
      {
        "location",
        icon = "",
      },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = {},
    lualine_y = {},
    lualine_z = { "location" },
  },
}

return M
