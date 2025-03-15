local config = function()
  vim.g.vimtex_view_method = "zathura_simple"
  vim.g.vimtex_compiler_method = "latexmk"
  vim.g.vimtex_compiler_latexmk = {
    build_dir = "out",
    aux_dir = "out",
    options = {
      "-pdf",
      "-synctex=1",
      "-shell-escape",
    },
  }
end

return config
