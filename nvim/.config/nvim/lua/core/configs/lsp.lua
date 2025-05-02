local M = {}

M.servers = {
  lua_ls = {
    settings = {
      Lua = {
        completion = { callSnippet = "Replace" },
      },
    },
  },
  bashls = {},
  html = {},
  cssls = {},
  astro = {},
  tailwindcss = {},
  emmet_language_server = {},
  pyright = {},
  rust_analyzer = {},
  clangd = {},
  ts_ls = {},
  jsonls = {},
  intelephense = {
    init_options = {
      storagePath = vim.fn.stdpath("cache") .. "/intelephense",
      globalStoragePath = vim.fn.stdpath("data") .. "/intelephense",
      licenceKey = nil,
      clearCache = false,
    },
    settings = {
      intelephense = {
        files = {
          maxSize = 5000000,
        },
      },
    },
  },
  texlab = {
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      M.on_attach(client, bufnr)
    end,
  },
  ltex_plus = {
    on_attach = function(client, bufnr)
      M.on_attach(client, bufnr)
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
            ["\\cite"] = "ignore",
            ["\\citep"] = "ignore",
            ["\\citet"] = "ignore",
            ["\\cref"] = "ignore",
            ["\\Cref"] = "ignore",
            ["\\autoref"] = "ignore",
            ["\\autocite"] = "ignore",
            ["\\autocites"] = "ignore",
            ["\\usepackage"] = "ignore",
            ["\\usepackage*"] = "ignore",
            ["\\documentclass"] = "ignore",
            ["\\begin"] = "ignore",
            ["\\end"] = "ignore",
            ["\\newcommand"] = "ignore",
            ["\\renewcommand"] = "ignore",
            ["\\DeclareMathOperator"] = "ignore",
            ["\\DeclareMathAlphabet"] = "ignore",
            ["\\DeclareMathSymbol"] = "ignore",
            ["\\DeclarePairedDelimiter"] = "ignore",
          },
        },
        diagnosticDelay = "1000ms",
      },
    },
  },
  hls = {
    filetypes = { "haskell" },
  },
}

---@type vim.lsp.client.on_attach_cb
M.on_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

  local map = function(keys, func, desc, mode)
    vim.keymap.set(mode or "n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
  end

  map("gd", require("snacks.picker").lsp_definitions, "[G]oto [D]efinition")
  map("gr", require("snacks.picker").lsp_references, "[G]oto [R]eferences")
  map("gI", require("snacks.picker").lsp_implementations, "[G]oto [I]mplementation")
  map("<leader>D", require("snacks.picker").lsp_type_definitions, "Type [D]efinition")
  map("<leader>ds", require("snacks.picker").lsp_symbols, "[D]ocument [S]ymbols")
  map("<leader>ws", require("snacks.picker").lsp_workspace_symbols, "[W]orkspace [S]ymbols")
  map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
  map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

  -- Inlay Hints toggle
  if vim.lsp.inlay_hint then
    map("<leader>th", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
    end, "[T]oggle Inlay [H]ints")
  end
end

local make_capabilities = vim.lsp.protocol.make_client_capabilities()
make_capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  deprecatedSupport = true,
  preselectSupport = true,
  snippetSupport = true,
  insertReplaceSupport = true,
  commitCharactersSupport = true,
  labelDetailsSupport = true,
  tagSupport = {
    valueSet = { 1 },
  },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

M.capabilities = vim.tbl_deep_extend("force", make_capabilities, require("blink-cmp").get_lsp_capabilities({}, false))

---@type vim.diagnostic.Opts
M.diagnostics = {
  severity_sort = true,
  float = { border = "rounded", source = "if_many" },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
  } or {},
  virtual_text = {
    source = "if_many",
    spacing = 2,
    format = function(diagnostic)
      return diagnostic.message
    end,
  },
}

return M
