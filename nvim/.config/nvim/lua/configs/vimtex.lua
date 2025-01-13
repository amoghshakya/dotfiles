local config = function()
  -- VimTeX configuration goes here, e.g.
  vim.g.vimtex_view_method = "zathura"
  vim.g.vimtex_compiler_latexmk = {
    options = {
      "--shell-escape",
      "-pdf",
      "-synctex=1",
      "-interaction=nonstopmode",
      "-file-line-error",
      "-outdir=out",
    },
  }
  vim.g.vimtex_format_enabled = 1
end

return config
