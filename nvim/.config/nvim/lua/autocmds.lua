local autocmd = vim.api.nvim_create_autocmd

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Close windows with `q`
autocmd("FileType", {
  pattern = { "qf", "help" },
  callback = function()
    vim.keymap.set("n", "q", "<cmd>bd<CR>", { silent = true, buffer = true })
  end,
})

-- Kitty padding
autocmd("VimEnter", {
  desc = "Remove kitty padding on startup",
  command = ":silent !kitty @ set-spacing padding=0 margin=0",
})

autocmd("VimLeavePre", {
  desc = "Remove kitty padding on startup",
  command = ":silent !kitty @ set-spacing padding=4 margin=0",
})
