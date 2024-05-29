-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- FONT
-- config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 15

-- COLOR
config.color_scheme = "Tokyo Night (Gogh)"

-- TAB BAR
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.status_update_interval = 1000
config.tab_bar_at_bottom = true
config.tab_max_width = 12
config.colors = {
	tab_bar = {
		-- Background
		background = "#1a1b26",
		-- Active tabs are the tabs that have focus
		active_tab = {
			bg_color = "#c0c0c0",
			fg_color = "#1a1b26",
			intensity = "Bold",
		},
		-- Inactive tabs are the tabs that do not have focus
		inactive_tab = {
			bg_color = "#1a1b26",
			fg_color = "#c0c0c0",
		},
		-- moves over inactive tabs
		inactive_tab_hover = {
			bg_color = "#2a2b36",
			fg_color = "#ffffff",
			-- italic = true,
		},
		-- The new tab button that let you create new tabs
		new_tab = {
			bg_color = "#1a1b26",
			fg_color = "#e0af68",
		},
		-- moves over the new tab button
		new_tab_hover = {
			bg_color = "#2a2b36",
			fg_color = "#ffffff",
		},
	},
}

-- WINDOW
config.window_decorations = "RESIZE"
config.window_close_confirmation = "AlwaysPrompt"
-- config.window_background_opacity = 0.92
-- config.macos_window_background_blur = 8

return config
