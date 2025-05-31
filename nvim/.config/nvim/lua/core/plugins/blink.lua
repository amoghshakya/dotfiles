--[[
-- blink.cmp
-- A completion engine for Neovim that provides a fast and flexible way to complete code.
--]]

return {
  {
    "saghen/blink.compat",
    -- use v2.* for blink.cmp v1.*
    version = "2.*",
    -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
    lazy = true,
    -- make sure to set opts so that lazy.nvim calls blink.compat's setup
    opts = {},
  },
  {
    "saghen/blink.cmp",
    event = { "InsertEnter" },
    version = "*",
    -- optional: provides snippets for the snippet source
    dependencies = {
      { "micangl/cmp-vimtex" },
      {
        "L3MON4D3/LuaSnip",
        event = { "InsertEnter" },
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
            return
          end
          return "make install_jsregexp"
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          {
            "rafamadriz/friendly-snippets",
            config = function()
              require("luasnip.loaders.from_vscode").lazy_load()
              require("luasnip.loaders.from_snipmate").lazy_load()
            end,
          },
        },
      },
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      snippets = {
        preset = "luasnip",
        score_offset = 50,
      },
      keymap = {
        preset = "enter",
        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.snippet_forward()
            end
          end,
          "select_next",
          "fallback",
        },
        ["<S-Tab>"] = {
          "snippet_backward",
          function(cmp)
            if cmp.snippet_active() then
              return cmp.snippet_backward()
            end
          end,
          "select_prev",
          "fallback",
        },
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "normal",
        kind_icons = {
          Method = "",
          Keyword = "󰌋",
          Constructor = "󰆧",
          Class = "",
          Interface = "",
          Struct = "",
          Variable = "󰀫",
          Snippet = "",
        },
      },

      completion = {
        menu = {
          border = "rounded",
          draw = {
            columns = {
              { "label", "label_description" },
              { "kind_icon", "kind", gap = 1 },
            },
            treesitter = { "lsp" },
          },
        },
        trigger = {
          show_on_trigger_character = false,
          show_on_blocked_trigger_characters = { "{", "\n", "\t", ">", " " },
        },
        documentation = {
          -- Show documentation beside the completion menu
          -- Really helpful for seeing what you're completing
          auto_show = true,
          window = {
            border = "rounded",
          },
        },
        list = {
          selection = {
            -- Preselect the first item in the list
            preselect = true,
            -- I like to insert on accept but not on select
            -- It's kind of annoying when you have to edit what you're typing
            -- but auto complete just updates what you were typing.
            auto_insert = false,
          },
        },
        accept = {
          -- Add brackets (if it's a function or method) on accepting completion
          auto_brackets = {
            enabled = true,
          },
        },
      },

      sources = {
        default = { "lsp", "path", "snippets", "lazydev", "vimtex" },
        providers = {
          lazydev = {
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
          vimtex = {
            name = "vimtex",
            module = "blink.compat.source",
            score_offset = -3,
          },
        },
      },

      signature = {
        enabled = true,
        window = {
          border = "rounded",
        },
      },

      fuzzy = { implementation = "prefer_rust" },

      -- Disable blink for commandline
      -- Fuzzy searching is nice but it's annoying on commandline
      cmdline = {
        enabled = false,
      },
    },
    opts_extend = { "sources.default" },
  },
}
