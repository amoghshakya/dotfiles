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
  -- Terminal
  {
    "<A-`>",
    function()
      require("snacks").terminal.toggle()
    end,
    mode = { "n", "t" },
    desc = "Snacks Terminal",
  },
  {
    "<A-i>",
    function()
      require("snacks.terminal")
        .get(vim.o.shell, {
          win = {
            position = "float",
          },
        })
        :toggle()
    end,
    mode = { "n", "t" },
    desc = "Snacks Terminal",
  },
}

---@type snacks.dashboard.Opts
M.dashboard = {
  enabled = true,
  preset = {
    header = table.concat(require("ascii").hydra, "\n"),
    keys = {
      -- Overriding the defaults so my custom Telescope themes and options persist
      { icon = " ", key = "f", desc = "Find file", action = ":Telescope find_files" },
      { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
      { icon = " ", key = "g", desc = "Find Text", action = ":Telescope live_grep" },
      { icon = " ", key = "r", desc = "Recent Files", action = ":Telescope oldfiles" },
      {
        icon = " ",
        key = "c",
        desc = "Config",
        action = function()
          require("telescope.builtin").find_files({
            prompt_title = "Config",
            cwd = vim.fn.stdpath("config"),
            hidden = true,
          })
        end,
      },
      { icon = " ", key = "s", desc = "Restore Session", section = "session" },
      { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
      { icon = " ", key = "q", desc = "Quit", action = ":qa" },
    },
  },
}

---@type snacks.terminal.Opts
M.terminal = {
  enabled = true,
  win = {
    style = "minimal",
    border = "rounded",
    backdrop = false,
  },
}

return M
