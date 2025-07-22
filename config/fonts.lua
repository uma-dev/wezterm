return function(config, wezterm)
	config.font_size = 14
	config.font = wezterm.font("JetBrains Mono")
	config.font_rules = {
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
end
