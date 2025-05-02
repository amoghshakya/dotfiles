local M = {}

-- Store for named terminals
M.terminals = {}

M.keys = {
  { -- TODO: Make the terminal toggleable with ToggleTerm keybindings
    "<leader>Tn",
    function()
      vim.ui.input({
        prompt = "Terminal name: ",
        default = "",
        completion = function()
          return vim.tbl_keys(M.terminals)
        end,
      }, function(input)
        if input == nil then
          return
        end

        -- Check if the terminal already exists
        if M.terminals[input] then
          vim.notify("Terminal with this name already exists", vim.log.levels.WARN)
          return
        end

        -- Create a new terminal with the given name
        local new_term = require("toggleterm.terminal").Terminal:new({
          id = input,
          hidden = true,
          direction = "horizontal",
          name = input,
        })
        new_term:toggle()
        M.terminals[input] = new_term
      end)
    end,
    mode = { "n", "t" },
    desc = "New terminal",
  },
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
}

return M
