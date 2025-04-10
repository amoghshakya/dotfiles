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

-- Enable spell checking for LaTeX files
-- Kinda annoying to have this on by default
-- but it's useful if English is not your first language
autocmd("FileType", {
  pattern = "tex",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
  end,
})

-- Close windows with `q`
autocmd("FileType", {
  pattern = { "qf", "help" },
  callback = function()
    vim.keymap.set("n", "q", "<cmd>bd<CR>", { silent = true, buffer = true })
  end,
})
