--[[
-- A very fast plugin for highlighting colors in files.
-- -- This plugin is useful for quickly identifying colors in code files, especially in CSS and HTML files.
--]]

return {
  "catgoose/nvim-colorizer.lua",
  -- Only start the plugin if the filetype is one of the following
  ft = { -- Get rid of this if you want to see colors in all filetypes
    "css",
    "scss",
    "less",
    "html",
    "javascript",
    "typescript",
    "javascriptreact",
    "typescriptreact",
    "vue",
    "svelte",
  },
  opts = {
    user_default_options = {
      css = true,
      tailwind = "both",
      tailwind_opts = {
        update_names = true,
      },
      sass = {
        enabled = true,
      },
      -- mode = "virtualtext", -- For VSCode-like color preview
      virtualtext = "",
      virtualtext_inline = "before",
    },
  },
}
