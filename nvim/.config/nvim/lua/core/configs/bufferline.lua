local M = {}

M.opts = function()
  local highlights = require("rose-pine.plugins.bufferline")
  return {
    highlights = highlights,
    options = {
      mode = "buffers", -- or "tabs"
      numbers = "none", -- or "ordinal" or "buffer_id"
      indicator = {
        style = "underline", -- can be "underline" or "none"
      },
      modified_icon = "",
      close_icon = "",
      buffer_close_icon = "",
      left_trunc_marker = "",
      right_trunc_marker = "",
      max_name_length = 18,
      max_prefix_length = 15,
      tab_size = 20,
      diagnostics = "nvim_lsp", -- show LSP diagnostics in tab
      diagnostics_indicator = function(count, level, _, _)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end,
      diagnostics_update_in_insert = false,
      custom_filter = function(buf, buf_nums)
        local exclude = { "toggleterm", "quickfix", "nofile" }
        local buftype = vim.bo[buf].buftype

        return not vim.tbl_contains(exclude, buftype)
      end,
      offsets = {
        {
          filetype = "neo-tree",
          text = "",
          separator = false,
        },
        {
          filetype = "toggleterm",
          text = "",
          separator = false,
        },
      },
      show_buffer_icons = true,
      show_buffer_close_icons = true,
      show_close_icon = true,
      show_tab_indicators = true,
      enforce_regular_tabs = false,
      persist_buffer_sort = true,
      separator_style = { "▏", "▏" },
      always_show_bufferline = true,
      hover = {
        enabled = true,
        delay = 200,
        reveal = { "close" },
      },
    },
  }
end

M.keys = {
  { "<Tab>", ":BufferLineCycleNext<CR>", desc = "Next buffer", silent = true },
  { "<S-Tab>", ":BufferLineCyclePrev<CR>", desc = "Previous buffer", silent = true },
}

return M
