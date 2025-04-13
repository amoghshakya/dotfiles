return {
  "mrjones2014/smart-splits.nvim",
  event = "VeryLazy",
  opts = {
    ignored_buftypes = {
      "nofile",
      "quickfix",
      "prompt",
      "terminal",
    },
    ignored_filetypes = {
      "neo-tree",
      "qf",
      "toggleterm",
    },
  },
  keys = {
    { "<A-h>", "<CMD>SmartResizeLeft<CR>", mode = { "n", "t" }, desc = "Resize left" },
    { "<A-j>", "<CMD>SmartResizeDown<CR>", mode = { "n", "t" }, desc = "Resize down" },
    { "<A-k>", "<CMD>SmartResizeUp<CR>", mode = { "n", "t" }, desc = "Resize up" },
    { "<A-l>", "<CMD>SmartResizeRight<CR>", mode = { "n", "t" }, desc = "Resize right" },
  },
}
