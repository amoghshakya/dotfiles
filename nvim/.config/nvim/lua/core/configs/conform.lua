local opts = {
  default_format_opts = {
    timeout_ms = 3000,
    async = false,
    quiet = false,
  },
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    scss = { "prettier" },
    html = { "prettier" },
    javascript = { "prettier", "prettierd", stop_after_first = true },
    javascriptreact = { "prettier", "prettierd", stop_after_first = true },
    typescript = { "prettier", "prettierd", stop_after_first = true },
    typescriptreact = { "prettier", "prettierd", stop_after_first = true },
    astro = { "prettier", "prettierd", stop_after_first = true },
    json = { "prettier" },
    jsonc = { "prettier" },
    python = { "autopep8", "isort" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    rust = { "rustfmt" },
    tex = { "latexindent" },
    plaintex = { "latexindent" },
    bib = { "bibtex-tidy" },
    typst = { "prettypst" },
    qml = { "qmlformat" },
    htmldjango = { "djlint" },
    sql = { "sql_formatter" },
    blade = { "blade-formatter" },
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
    php_cs_fixer = {
      env = {
        PHP_CS_FIXER_IGNORE_ENV = "1",
      },
    },
    qmlformat = {
      command = "qmlformat",
      args = { "", "$FILENAME" },
    },
    ["blade-formatter"] = {
      command = "blade-formatter",
      args = { "--stdin", "--sort-tailwindcss-classes" },
      stdin = true,
    },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 1000,
    lsp_format = true,
  },
}

return opts
