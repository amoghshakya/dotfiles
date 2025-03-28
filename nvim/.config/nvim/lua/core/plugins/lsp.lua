-- LSP Plugins

return {
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = {
          path = "skip",
          ui = {
            icons = {
              package_pending = " ",
              package_installed = " ",
              package_uninstalled = " ",
            },
          },
        },
      },
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      { "j-hui/fidget.nvim", opts = {} },
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lsp_attach = require("configs.lsp").on_attach
      local capabilities = require("configs.lsp").capabilities

      local mason_registry = require("mason-registry")

      -- LSP servers
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = "Replace" },
            },
          },
        },
        html = {},
        cssls = {},
        pyright = {},
        rust_analyzer = {},
        ts_ls = {},
        jsonls = {},
        texlab = {
          settings = {
            texlab = {
              latexFormatter = "latexindent",
              latexindent = {
                modifyLineBreaks = false,
              },
            },
          },
        },
        ltex_plus = {
          on_attach = function(client, bufnr)
            lsp_attach(client, bufnr)
            require("ltex_extra").setup({
              path = vim.fn.expand("~/.local/share/nvim/ltex/"),
              load_langs = { "en-US" },
              init_check = true,
            })
          end,
          settings = {
            ltex = {
              language = "en-US",
              completionEnabled = true,
              enabled = { "latex", "tex", "markdown", "mdx" },
              additionalRules = {
                enablePickyRules = true,
                motherTongue = "en-US",
              },
              latex = {
                commands = {
                  ["\\caption"] = "ignore",
                },
              },
            },
          },
        },
      }

      local ensure_installed = {}

      local lspconfig_to_package = require("mason-lspconfig.mappings.server").lspconfig_to_package
      for server, _ in pairs(servers) do
        local mason_name = lspconfig_to_package[server]
        if mason_name then
          local ok, pkg = pcall(mason_registry.get_package, mason_name)
          if ok then
            local found = false
            for bin, _ in pairs(pkg.spec.bin or {}) do
              if vim.fn.executable(bin) == 1 then
                found = true
                break
              end
            end

            if not found then
              table.insert(ensure_installed, server)
            end
          else
            -- Not in mason registry, still ensure installed (local servers)
            table.insert(ensure_installed, server)
          end
        end
      end

      vim.list_extend(ensure_installed, {
        "stylua",
      })

      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      require("mason-lspconfig").setup({
        ensure_installed = {},
        automatic_installation = false,
      })

      for server_name, server in pairs(servers) do
        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
        server.on_attach = server.on_attach or lsp_attach
        require("lspconfig")[server_name].setup(server)
      end

      vim.diagnostic.config(require("configs.lsp").diagnostics)
    end,
  },
}
