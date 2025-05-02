--[[
-- A very fast plugin for highlighting colors in files.
-- -- This plugin is useful for quickly identifying colors in code files, especially in CSS and HTML files.
--]]

return {
  "catgoose/nvim-colorizer.lua",
  event = "BufReadPre",
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
      -- For VSCode-like color preview
      -- mode = "virtualtext",
      virtualtext = "",
      virtualtext_inline = "before",
    },
  },
}
