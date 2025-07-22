return function(config, wezterm)
	config.color_scheme = "Tokyo Night (Gogh)"

	config.use_fancy_tab_bar = false
	-- config.hide_tab_bar_if_only_one_tab = true
	config.status_update_interval = 300
	config.tab_bar_at_bottom = true
	config.tab_max_width = 12

	config.colors = {
		tab_bar = {
			background = "#1a1b26",

			active_tab = {
				bg_color = "#c0c0c0",
				fg_color = "#1a1b26",
				intensity = "Bold",
			},

			inactive_tab = {
				bg_color = "#1a1b26",
				fg_color = "#c0c0c0",
			},

			inactive_tab_hover = {
				bg_color = "#2a2b36",
				fg_color = "#ffffff",
			},

			new_tab = {
				bg_color = "#1a1b26",
				fg_color = "#e0af68",
			},

			new_tab_hover = {
				bg_color = "#2a2b36",
				fg_color = "#ffffff",
			},
		},

		compose_cursor = "orange",
	}
end
