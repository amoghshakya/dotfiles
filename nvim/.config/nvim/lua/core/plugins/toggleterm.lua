return {
  "akinsho/toggleterm.nvim",
  event = "VeryLazy",
  version = "*",
  opts = {
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return math.floor(vim.o.columns * 0.4) -- 40% of the screen width
      end
    end,
    hide_numbers = true,
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    direction = "horizontal", -- default, can be "horizontal", "vertical", or "float"
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
      border = "curved",
      winblend = 0,
    },
  },
  keys = {
    {
      "<A-`>",
      "<Cmd>ToggleTerm direction=horizontal<CR>",
      mode = { "n", "t" },
      desc = "Toggle horizontal terminal",
    },
    {
      "<A-v>",
      "<Cmd>ToggleTerm direction=vertical<CR>",
      mode = { "n", "t" },
      desc = "Toggle vertical terminal",
    },
    {
      "<A-i>",
      "<Cmd>ToggleTerm direction=float<CR>",
      mode = { "n", "t" },
      desc = "Toggle floating terminal",
    },
  },
}
