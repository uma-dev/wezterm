return function(config, wezterm)
	config.window_background_opacity = 0.92
	config.macos_window_background_blur = 16

	-- For Linux: ensure windows close properly
	-- config.window_decorations = "RESIZE | TITLE"
	config.window_decorations = "RESIZE"

	config.window_close_confirmation = "AlwaysPrompt"

	config.initial_rows = 55
	config.initial_cols = 100

	-- Optional: skip confirmation when closing empty panes
	config.skip_close_confirmation_for_processes_named = {}
end
