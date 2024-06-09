-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- FONT
config.font_size = 15
config.font = wezterm.font("JetBrains Mono")
config.font_rules = {
	-- For Bold-but-not-italic text, use this relatively bold font, and override
	{
		intensity = "Bold",
		italic = false,
		font = wezterm.font({
			family = "JetBrains Mono",
			weight = "Bold",
		}),
	},
	{
		intensity = "Bold",
		italic = true,
		font = wezterm.font({
			family = "JetBrains Mono",
			weight = "Bold",
			italic = true,
		}),
	},
}

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
-- config.window_background_opacity = 0.92
-- config.macos_window_background_blur = 8
config.window_decorations = "RESIZE"
config.window_close_confirmation = "AlwaysPrompt"

-- KEYS
config.keys = {
	{
		key = "w",
		mods = "CMD",
		action = wezterm.action.CloseCurrentTab({ confirm = true }),
	},
}
-- Keys
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	-- Send C-a when pressing C-a twice
	{ key = "a", mods = "LEADER|CTRL", action = act.SendKey({ key = "a", mods = "CTRL" }) },
	{ key = "c", mods = "LEADER", action = act.ActivateCopyMode },
	{ key = "phys:Space", mods = "LEADER", action = act.ActivateCommandPalette },

	-- Pane keybindings
	{ key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "|", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	-- { key = "h", mods = "CTRL", action = act.ActivatePaneDirection("Left") },
	-- { key = "j", mods = "CTRL", action = act.ActivatePaneDirection("Down") },
	-- { key = "k", mods = "CTRL", action = act.ActivatePaneDirection("Up") },
	-- { key = "l", mods = "CTRL", action = act.ActivatePaneDirection("Right") },
	-- { key = "q", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
	{ key = "m", mods = "LEADER", action = act.TogglePaneZoomState },
	{
		key = "r",
		mods = "LEADER",
		action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }),
	},
}

config.key_tables = {
	resize_pane = {
		{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
	},
}

-- config to skip no process when confirm
config.skip_close_confirmation_for_processes_named = {}

return config
