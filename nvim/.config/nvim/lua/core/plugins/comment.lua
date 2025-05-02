--[[
-- https://github.com/numToStr/Comment.nvim
-- Really neat plugin for commenting out code.
-- For a minimal setup, the built-in commentstring command can be enough.
-- But this plugin is great for more complex commenting needs.
--]]

return {
  "numToStr/Comment.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    { -- For context-aware commenting like in tsx or markdown files
      "JoosepAlviste/nvim-ts-context-commentstring",
      event = { "BufReadPost", "BufNewFile" },
      opts = {
        enable_autocmd = false,
      },
    },
  },
  opts = function()
    -- Pass options below
    return {
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    }
  end,
}
