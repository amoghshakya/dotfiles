return {
  "saghen/blink.cmp",
  event = { "InsertEnter" },
  version = "*",
  -- optional: provides snippets for the snippet source
  dependencies = {
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
        show_on_trigger_character = true,
      },
      documentation = { auto_show = false },
      list = {
        selection = {
          preselect = true,
          auto_insert = false,
        },
      },
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
    },

    sources = {
      default = { "lsp", "path", "snippets", "lazydev" },
      providers = {
        lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
      },
    },

    signature = {
      enabled = true,
      window = {
        border = "rounded",
      },
    },

    fuzzy = { implementation = "prefer_rust" },
    cmdline = {
      enabled = false,
    },
  },
  opts_extend = { "sources.default" },
}
