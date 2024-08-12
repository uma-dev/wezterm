-- Pull in the wezterm API
local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action
local config = wezterm.config_builder()

-- FONT
config.font_size = 16
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
-- config.hide_tab_bar_if_only_one_tab = true
config.status_update_interval = 300
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
	-- recolor cursor when leader active
	compose_cursor = "orange",
}
wezterm.on("update-status", function(window, pane)
	-- Workspace name
	local stat = window:active_workspace()
	local stat_color = "#9d9df7"
	local first_color = "#c0c0c0"
	-- It's a little silly to have workspace name all the time
	-- Utilize this to display LDR or current key table name
	if window:active_key_table() then
		stat = window:active_key_table()
		stat_color = "#7dcfff"
	end
	if window:leader_is_active() then
		-- stat = "LDR"
		stat_color = "orange"
	end

	local basename = function(s)
		-- Nothing a little regex can't fix
		return string.gsub(s, "(.*[/\\])(.*)", "%2")
	end

	-- Current working directory
	local cwd = pane:get_current_working_dir()
	if cwd then
		if type(cwd) == "userdata" then
			-- Wezterm introduced the URL object in 20240127-113634-bbcac864
			cwd = basename(cwd.file_path)
		else
			-- 20230712-072601-f4abf8fd or earlier version
			cwd = basename(cwd)
		end
	else
		cwd = ""
	end

	-- Current command
	local cmd = pane:get_foreground_process_name()
	-- CWD and CMD could be nil (e.g. viewing log using Ctrl-Alt-l)
	cmd = cmd and basename(cmd) or ""

	-- Right status
	window:set_right_status(wezterm.format({
		{ Foreground = { Color = first_color } },
		{ Text = wezterm.nerdfonts.md_folder .. "  " .. cwd },
		{ Text = " | " },
		{ Text = wezterm.nerdfonts.fa_code .. "  " .. cmd },
		{ Text = " | " },
		{ Foreground = { Color = stat_color } },
		{ Text = wezterm.nerdfonts.oct_table .. "  " .. stat },
		{ Text = " " },
	}))
end)

-- WINDOW
-- config.window_background_opacity = 0.92
-- config.macos_window_background_blur = 8
-- Avoid not closing widown in linux with
-- config.window_decorations = "RESIZE | TITLE"
config.window_decorations = "RESIZE"
config.window_close_confirmation = "AlwaysPrompt"
config.initial_rows = 55
config.initial_cols = 100

-- KEYS
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	-- Send C-a when pressing C-a twice
	{ key = "a", mods = "LEADER|CTRL", action = act.SendKey({ key = "a", mods = "CTRL" }) },
	{ key = "c", mods = "LEADER", action = act.ActivateCopyMode },
	{ key = "phys:Space", mods = "LEADER", action = act.ActivateCommandPalette },
	-- Pane keybindings
	{ key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	-- Needs shift as mod in linux to avoid skipping | character (shift + \)
	{ key = "|", mods = "LEADER|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
	{ key = "q", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
	{ key = "m", mods = "LEADER", action = act.TogglePaneZoomState },
	{
		key = "r",
		mods = "LEADER",
		action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }),
	},
	-- Tab keybindings
	-- { key = "[", mods = "LEADER", action = act.ActivateTabRelative(-1) },
	-- { key = "]", mods = "LEADER", action = act.ActivateTabRelative(1) },
	-- { key = "n", mods = "LEADER", action = act.ShowTabNavigator },
	{
		key = "e",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { AnsiColor = "Fuchsia" } },
				{ Text = "New Tab Title: " },
			}),
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
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
