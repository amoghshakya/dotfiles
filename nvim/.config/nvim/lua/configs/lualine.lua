local M = {}

local excluded_filetypes = {
  "TelescopePrompt",
  "toggleterm",
  "snacks_dashboard",
  "neo-tree",
}

local exclude = function()
  return not vim.tbl_contains(excluded_filetypes, vim.bo.filetype)
end

M.opts = {
  options = {
    theme = "auto",
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
    globalstatus = true, -- Show one statusline across splits (optional but nice)
    disabled_filetypes = {
      statusline = { "alpha", "lazy", "mason" },
      winbar = {},
    },
  },
  refresh = {
    statusline = 100,
    tabline = 100,
    winbar = 100,
  },
  sections = {
    lualine_a = {
      {
        "mode",
        icons_enabled = true,
        icon = "",
      },
    },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = {
      {
        "filename",
        cond = exclude,
      },
    },
    lualine_x = {
      {
        "lsp_status",
        symbols = {
          separator = " ~ ",
        },
      },
      {
        "filetype",
        cond = exclude,
      },
    },
    lualine_y = {},
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
