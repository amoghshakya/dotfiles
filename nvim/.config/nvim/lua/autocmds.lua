require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd

autocmd("VimEnter", {
    command = ":silent !kitty @ set-spacing padding=0 margin=0",
})

autocmd("VimLeavePre", {
    command = ":silent !kitty @ set-spacing padding=4 margin=default",
})
