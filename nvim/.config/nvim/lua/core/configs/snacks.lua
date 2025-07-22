local M = {}

M.keys = {
  -- Lazygit
  {
    "<leader>lg",
    function()
      Snacks.lazygit()
    end,
    desc = "Lazygit",
  },
  -- Picker
  {
    "<leader>st",
    function()
      Snacks.picker.todo_comments({
        layout = {
          preset = "vertical",
        },
      })
    end,
    desc = "[S]earch [T]odo",
  },
  {
    "<leader>sf",
    function()
      Snacks.picker.files()
    end,
    desc = "[S]earch [F]iles",
  },
  {
    "<leader>sk",
    function()
      Snacks.picker.keymaps()
    end,
    desc = "[S]earch [K]eymaps",
  },
  {
    "<leader>sh",
    function()
      Snacks.picker.help()
    end,
    desc = "[S]earch [H]elp",
  },
  {
    "<leader>sg",
    function()
      Snacks.picker.grep()
    end,
    desc = "[S]earch [G]rep",
  },
  {
    "<leader>ss",
    function()
      Snacks.picker()
    end,
    desc = "[S]earch [S]elect",
  },
  {
    "<leader>sw",
    function()
      Snacks.picker.grep_word()
    end,
    desc = "[S]earch current [W]ord",
  },
  {
    "<leader>sr",
    function()
      Snacks.picker.resume()
    end,
    desc = "[S]earch [R]esume",
  },
  {
    "<leader>s.",
    function()
      Snacks.picker.recent()
    end,
    desc = "[S]earch Recent Files ('.' for repeat)",
  },
  {
    "<leader>sd",
    function()
      Snacks.picker.diagnostics()
    end,
    desc = "[S]earch [D]iagnostics",
  },
  {
    "<leader>sc",
    function()
      Snacks.picker.colorschemes()
    end,
    desc = "[S]earch [C]olorschemes",
  },
  {
    "<leader>sp",
    function()
      Snacks.picker.zoxide({
        title = "Projects",
        layout = {
          preset = "vscode",
        },
      })
    end,
    desc = "[S]earch [P]rojects",
  },
  {
    "<leader>sn",
    function()
      Snacks.picker.files({
        cwd = vim.fn.stdpath("config"),
        title = "Neovim Configs",
      })
    end,
    desc = "[S]earch [N]eovim Configs",
  },
  {
    "<leader>/",
    function()
      Snacks.picker.lines()
    end,
    desc = "[/] Fuzzily search in current buffer",
  },
  {
    "<leader>s/",
    function()
      Snacks.picker.grep_buffers()
    end,
    desc = "[S]earch [/] in Open Files",
  },
  {
    "<leader><leader>",
    function()
      Snacks.picker.buffers()
    end,
    desc = "[ ] Find existing buffers",
  },
  {
    "<leader>gl",
    function()
      Snacks.picker.git_log({
        layout = "vertical",
      })
    end,
    desc = "[G]it [L]ogs",
  },
  {
    "<leader>ft",
    function()
      -- This is a custom picker defined in the config below
      Snacks.picker.filetypes()
    end,
    desc = "[F]ile[t]ypes",
  },
}

---@type snacks.picker.Config
M.picker = {
  enabled = true,
  prompt = "   ",
  layout = {
    cycle = false,
  },
  matcher = {
    frecency = true,
  },
  -- layouts = {
  --   default = {
  --     layout = {
  --       box = "horizontal",
  --       width = 0.8,
  --       min_width = 120,
  --       height = 0.8,
  --       backdrop = false,
  --       {
  --         box = "vertical",
  --         border = "solid",
  --         title = "{title} {live} {flags}",
  --         { win = "input", height = 1, border = "bottom" },
  --         { win = "list", border = "none" },
  --       },
  --       { win = "preview", title = "{preview}", border = "solid", width = 0.5 },
  --     },
  --   },
  --   vertical = {
  --     layout = {
  --       backdrop = false,
  --       width = 0.8,
  --       min_width = 80,
  --       height = 0.8,
  --       min_height = 30,
  --       box = "vertical",
  --       border = "solid",
  --       title = "{title} {live} {flags}",
  --       title_pos = "center",
  --       { win = "input", height = 1, border = "bottom" },
  --       { win = "list", border = "none" },
  --       { win = "preview", title = "{preview}", height = 0.4, border = "top" },
  --     },
  --   },
  -- },
  sources = {
    files = {
      hidden = true,
      ignored = true,
      exclude = {
        "**/.git/*",
        "**/node_modules/*",
        "**/vendor/*",
        "**/.cache/*",
        "**/.DS_Store",
        "**/.idea/*",
        "**/.vscode/*",
        "**/.sass-cache/*",
        "**/.next/*",
        "**/dist/*",
        "**/build/*",
      },
    },
    filetypes = {
      name = "filetypes",
      format = "text",
      preview = "none",
      layout = { preset = "vscode" },
      confirm = function(picker, item)
        picker:close()
        if item then
          vim.schedule(function()
            vim.cmd("setfiletype " .. item.text)
          end)
        end
      end,
      finder = function()
        local items = {}
        local filetypes = vim.fn.getcompletion("", "filetype")
        for _, type in ipairs(filetypes) do
          items[#items + 1] = {
            text = type,
          }
        end
        return items
      end,
    },
    pickers = {
      finder = "meta_pickers",
      format = "text",
      layout = {
        preset = "vscode",
      },
    },
    colorschemes = {
      finder = "vim_colorschemes",
      format = "text",
      preview = "colorscheme",
      layout = {
        preset = "vscode",
      },
      on_change = function(_, item)
        if item then
          vim.cmd("colorscheme " .. item.text)
        end
      end,
      confirm = function(picker, item)
        picker:close()
        if item then
          picker.preview.state.colorscheme = nil
          vim.schedule(function()
            vim.cmd("colorscheme " .. item.text)
          end)
        end
      end,
    },
    keymaps = {
      layouts = {
        default = {
          layout = {
            box = "vertical",
            width = 0.8,
            height = 0.8,
            {
              box = "vertical",
              border = "solid",
              title = "{title} {live} {flags}",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
            },
          },
        },
      },
    },
  },
}

---@type snacks.dashboard.Config
M.dashboard = {
  enabled = true,
  preset = {
    header = table.concat(require("ascii").sharp, "\n"),
  },
}

---@type snacks.terminal.Config
M.terminal = {
  enabled = true,
  win = {
    style = "minimal",
    border = "rounded",
    backdrop = false,
  },
}

return M
