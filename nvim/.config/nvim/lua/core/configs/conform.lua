local opts = {
  default_format_opts = {
    timeout_ms = 3000,
    async = false,
    quiet = false,
    lsp_format = "fallback",
  },
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    javascript = { "prettier", "prettierd", stop_after_first = true },
    json = { "prettier" },
    jsonc = { "prettier" },
    python = { "autopep8", "isort" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    tex = { "latexindent" },
    plaintex = { "latexindent" },
    bib = { "bibtex-tidy" },
  },
  formatters = {
    latexindent = {
      command = "latexindent",
      args = {
        "-y=defaultIndent: '  '",
        "-m",
        "-g=/dev/null",
      },
    },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 1000,
  },
}

return opts
