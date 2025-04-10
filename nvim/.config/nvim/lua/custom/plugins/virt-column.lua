return {
  "lukas-reineke/virt-column.nvim",
  event = "BufReadPost",
  opts = {
    char = "│",
    virtcolumn = "80",
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
          require("virt-column").update({
            virtcolumn = "",
          })
        end
      end,
    })
  end,
}
