return { -- Tabs
  "akinsho/bufferline.nvim",
  version = "*",
  event = "UIEnter",
  dependencies = "nvim-tree/nvim-web-devicons",
  keys = require("core.configs.bufferline").keys,
  opts = require("core.configs.bufferline").opts,
}
