local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    javascript = { "prettier", "prettierd", stop_after_first = true },
    python = { "autopep8", "isort", "black" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    tex = { "latexindent" },
    bib = { "bibtidy" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
  },
}

return options
