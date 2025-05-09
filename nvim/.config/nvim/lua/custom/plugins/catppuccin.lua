return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000, -- Ensure it loads first
  opts = {
    flavour = "mocha", -- latte, frappe, macchiato, mocha or auto
    transparent_background = false,
    term_colors = true,
    dim_inactive = {
      enabled = true,
    },
    custom_highlights = function(colors)
      -- Fix for snacks.nvim picker until it's fixed
      return {
        NormalFloat = { bg = colors.base, fg = colors.text },
      }
    end,
    default_integrations = true,
    integrations = {
      treesitter = true,
      treesitter_context = true,
      gitsigns = true,
      blink_cmp = false,
      neotree = true,
      copilot_vim = true,
      dap_ui = true,
      dropbar = {
        enabled = true,
        color_mode = true, -- enable color for kind's texts, not just kind's icons
      },
      nvim_surround = true,
      snacks = {
        enabled = true,
        indent_scope_color = "lavender",
      },
      which_key = true,
    },
  },
  init = function()
    vim.cmd("colorscheme catppuccin")
  end,
}
