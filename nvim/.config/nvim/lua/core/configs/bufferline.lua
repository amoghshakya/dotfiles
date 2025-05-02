local M = {}

M.opts = function()
  return {
    options = {
      modified_icon = "",
      close_icon = "",
      buffer_close_icon = "",
      left_trunc_marker = "",
      right_trunc_marker = "",
      max_name_length = 18,
      max_prefix_length = 15,
      tab_size = 20,
      diagnostics = "nvim_lsp", -- show LSP diagnostics in tab
      diagnostics_indicator = function(_, _, diag)
        local icons = {
          Error = " ",
          Warn = " ",
          Hint = " ",
          Info = " ",
        }
        local ret = (diag.error and icons.Error .. diag.error .. " " or "")
          .. (diag.warning and icons.Warn .. diag.warning or "")
        return vim.trim(ret)
      end,
      diagnostics_update_in_insert = false,
      custom_filter = function(buf, _)
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
          filetype = "snacks_picker_list",
          text = "",
          separator = true,
        },
        {
          filetype = "toggleterm",
          text = "",
          separator = false,
        },
        {
          filetype = "help",
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
      name_formatter = function(buf)
        local name = buf.name
        local path = buf.path

        local filename = vim.fn.fnamemodify(name, ":t")
        local is_index = filename:match("^index%.[tj]sx?$")

        if is_index then
          local dirname = vim.fn.fnamemodify(path, ":h:t")
          return dirname .. " - Component"
        end

        return filename
      end,
    },
  }
end

M.keys = {
  { "<Tab>", "<CMD>BufferLineCycleNext<CR>", desc = "Next buffer", silent = true },
  { "<S-Tab>", "<CMD>BufferLineCyclePrev<CR>", desc = "Previous buffer", silent = true },
  { "<leader>bc", "<CMD>BufferLinePick<CR>", desc = "Pick buffer", silent = true },
}

return M
