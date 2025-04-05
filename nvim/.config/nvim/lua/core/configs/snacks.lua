local M = {}

M.keys = {
  -- Lazygit
  {
    "<leader>lg",
    function()
      require("snacks").lazygit()
    end,
    desc = "Lazygit",
  },
}

return M
