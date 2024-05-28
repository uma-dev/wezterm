-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 15

-- For example, changing the color scheme:
config.color_scheme = "Tokyo Night (Gogh)"

config.enable_tab_bar = false

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.9
config.macos_window_background_blur = 8

-- and finally, return the configuration to wezterm
return config
