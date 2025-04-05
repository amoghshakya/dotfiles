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
    { "<leader>kys", "<cmd>ShowkeysToggle<CR>", desc = "Showkeys Toggle" },
  },
}
