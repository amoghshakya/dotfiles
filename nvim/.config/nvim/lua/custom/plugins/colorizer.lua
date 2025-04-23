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
      -- mode = "virtualtext",
      virtualtext = "",
      virtualtext_inline = "before",
    },
  },
}
