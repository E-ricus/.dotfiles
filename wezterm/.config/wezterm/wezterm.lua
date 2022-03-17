local wezterm = require("wezterm")

local mykeys = {
	{
		key = "%",
		mods = "CTRL|SHIFT",
		action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
	},
	{
		key = "s",
		mods = "CTRL|SHIFT",
		action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
	},
}
for i = 1, 8 do
	-- CTRL number to activate that tab
	table.insert(mykeys, {
		key = tostring(i),
		mods = "CTRL",
		action = wezterm.action({ ActivateTab = i - 1 }),
	})
end

return {
	font = wezterm.font("JetBrainsMono Nerd Font"),
	font_size = 17,
	color_scheme = "DoomOne",
	keys = mykeys,
}
