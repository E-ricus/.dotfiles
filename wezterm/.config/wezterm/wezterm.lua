local wezterm = require("wezterm")

local config = {
	-- font = wezterm.font("JetBrainsMono Nerd Font"),
	font_size = 16,
	color_scheme = "Catppuccin Mocha",
	hide_tab_bar_if_only_one_tab = true,
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
}

-- config.default_prog = { '/home/ericus/.cargo/bin/nu' }

return config
