-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font_size = 10
config.font = wezterm.font("JetBrainsMono Nerd Font")
-- config.font = wezterm.font_with_fallback({ "JetBrainsMono Nerd Font", "Symbols Nerd Font" })
-- config.color_scheme = "Catppuccin Mocha"

-- Window padding
config.window_padding = {
	left = 4,
	right = 4,
	top = 4,
	bottom = 4,
}

-- No fancy tab bar
config.use_fancy_tab_bar = false
-- config.enable_tab_bar = false

-- Keybinds
config.keys = {
	-- Fullscreen
	{ key = "F11", action = wezterm.action.ToggleFullScreen },
	{ key = "Enter", mods = "CTRL", action = wezterm.action.ToggleFullScreen },

	-- Open config file
	{
		key = ",",
		mods = "CTRL",
		action = wezterm.action.SpawnCommandInNewWindow({
			args = { "nvim", wezterm.config_file },
		}),
	},
}

-- Some neovim stuff
-- Basically, set the window padding to 0 when nvim is the foreground process
-- Kinda like kitty remote control, but not exactly
wezterm.on("update-status", function(window, pane)
	local info = pane:get_foreground_process_info()
	if info == nil then
		return
	end
	if info.name == "nvim" then
		window:set_config_overrides({
			window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
		})
	else
		window:set_config_overrides({
			window_padding = { left = 4, right = 4, top = 4, bottom = 4 },
		})
	end
end)

-- Finally, return the configuration to wezterm:
return config
