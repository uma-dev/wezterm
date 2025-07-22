return function(config, wezterm)
	wezterm.on("update-status", function(window, pane)
		local stat = window:active_workspace()
		local stat_color = "#9d9df7"
		local first_color = "#c0c0c0"

		if window:active_key_table() then
			stat = window:active_key_table()
			stat_color = "#7dcfff"
		end

		if window:leader_is_active() then
			stat_color = "orange"
		end

		local function basename(s)
			return string.gsub(s, "(.*[/\\])(.*)", "%2")
		end

		local cwd = pane:get_current_working_dir()
		if cwd then
			cwd = type(cwd) == "userdata" and basename(cwd.file_path) or basename(cwd)
		else
			cwd = ""
		end

		local cmd = pane:get_foreground_process_name()
		cmd = cmd and basename(cmd) or ""

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
end
