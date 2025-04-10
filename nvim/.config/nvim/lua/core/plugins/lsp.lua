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
    event = { "LspAttach", "BufReadPre" },
    dependencies = {
      "saghen/blink.cmp",
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
      {
        "j-hui/fidget.nvim",
        event = "LspAttach",
        opts = {
          progress = {
            ignore = {
              "ltex_plus",
            },
          },
        },
      },
    },
    config = function()
      local lsp_attach = require("core.configs.lsp").on_attach
      local capabilities = require("core.configs.lsp").capabilities

      local mason_registry = require("mason-registry")

      -- LSP servers
      local servers = require("core.configs.lsp").servers

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

      vim.diagnostic.config(require("core.configs.lsp").diagnostics)
    end,
  },
}
