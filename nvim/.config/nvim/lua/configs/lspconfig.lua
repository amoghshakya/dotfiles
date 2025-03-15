-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "pyright", "rust_analyzer", "clangd", "ts_ls", "eslint", "texlab", "jsonls" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

lspconfig.ltex_plus.setup {
  on_attach = function(client, bufnr)
    nvlsp.on_attach(client, bufnr)
    require("ltex_extra").setup {
      path = vim.fn.expand "~/.local/share/nvim/ltex/",
      load_langs = { "en-US" },
      init_check = true,
    }
  end,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
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
}

-- configuring single server, example: typescript
-- lspconfig.tsserver.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
