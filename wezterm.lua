local wezterm = require("wezterm")
local config = wezterm.config_builder()

for _, module in ipairs({
	"config.fonts",
	"config.colors",
	"config.window",
	"config.keys",
	"config.status",
}) do
	local m = require(module)
	if type(m) == "function" then
		m(config, wezterm)
	end
end

return config
