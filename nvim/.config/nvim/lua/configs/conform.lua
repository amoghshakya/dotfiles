local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    javascript = { "prettier", "prettierd", stop_after_first = true },
    json = { "prettier" },
    jsonc = { "prettier" },
    python = { "autopep8", "isort", "black" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    tex = { "latexindent" },
    plaintex = { "latexindent" },
    bib = { "bibtex-tidy" },
  },

  formatters = {
    latexindent = {
      command = "latexindent",
      args = { "-m", "-l", "-g=/dev/null" },
      "--yaml=indentChar:'  '",
    },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_format = "fallback",
  },
}

return options
