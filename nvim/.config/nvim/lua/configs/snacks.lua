local M = {}

M.keys = {
  -- Lazygit
  {
    "<leader>lg",
    function()
      require("snacks").lazygit()
    end,
  },
}

return M
