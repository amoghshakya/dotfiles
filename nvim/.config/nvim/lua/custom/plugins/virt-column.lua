return {
  "lukas-reineke/virt-column.nvim",
  event = "BufReadPost",
  ft = { "python", "lua", "tex" },
  opts = {
    char = "│",
    virtcolumn = "",
  },
  init = function()
    vim.api.nvim_create_autocmd({ "InsertEnter", "CursorMoved" }, {
      pattern = { "*.py", "*.lua", "*.tex" },
      callback = function()
        local line_length = vim.api.nvim_get_current_line():len()
        if line_length > 79 then
          vim.opt_local.colorcolumn = "80"
        else
          vim.opt_local.colorcolumn = ""
          require("virt-column").update({
            virtcolumn = "",
          })
        end
      end,
    })
  end,
}
