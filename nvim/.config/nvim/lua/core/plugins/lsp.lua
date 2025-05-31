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
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    },
  },
  { -- `pmizio/typescript-tools.nvim` provides TypeScript and JavaScript LSP support
    -- with additional features like code actions, formatting, and more
    "pmizio/typescript-tools.nvim",
    event = { "VeryLazy" },
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    event = { "VeryLazy", "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "mason-org/mason.nvim",
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
      "mason-org/mason-lspconfig.nvim",
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

      local mlsp = require("mason-lspconfig")
      local lspconfig_to_package = mlsp.get_mappings().lspconfig_to_package

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

      require("mason-tool-installer").setup({ ensure_installed = ensure_installed, auto_update = true })

      require("mason-lspconfig").setup({
        ensure_installed = {},
        automatic_installation = false,
      })

      for server, config in pairs(servers) do
        config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
        config.on_attach = config.on_attach or lsp_attach
        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end

      vim.diagnostic.config(require("core.configs.lsp").diagnostics)
    end,
  },
  {
    "Bekaboo/dropbar.nvim",
    event = { "LspAttach" },
    keys = {
      {
        "<Leader>;",
        function()
          require("dropbar.api").pick()
        end,
        desc = "Pick symbols in winbar",
      },
      {
        "[;",
        function()
          require("dropbar.api").goto_context_start()
        end,
        desc = "Go to start of current context",
      },
      {
        "];",
        function()
          require("dropbar.api").select_next_context()
        end,
        desc = "Select next context",
      },
    },
  },
}
