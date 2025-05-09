--[[
-- Just a simple plugin to show the keys you are pressing
-- I just have it for fun, but it's useful to see how inefficient 
-- I can be when using vim.
--]]

return {
  "nvzone/showkeys",
  cmd = "ShowkeysToggle",
  opts = {
    position = "top-right",
    excluded_modes = { "i" },
    keyformat = {
      ["<BS>"] = "󰁮 ",
      ["<CR>"] = "󰘌",
      ["<Space>"] = "󱁐",
      ["<Up>"] = "󰁝",
      ["<Down>"] = "󰁅",
      ["<Left>"] = "󰁍",
      ["<Right>"] = "󰁔",
      ["<PageUp>"] = "Page 󰁝",
      ["<PageDown>"] = "Page 󰁅",
      ["<M>"] = "󰘵",
      ["<C>"] = "󰘴",
      ["<S>"] = "󰘶",
    },
  },
  keys = {
    { "<leader>tk", "<cmd>ShowkeysToggle<CR>", desc = "Toggle Showkeys" },
  },
}
