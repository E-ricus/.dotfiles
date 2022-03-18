local wezterm = require("wezterm")

local mykeys = {
	{
		key = "mapped:v",
		mods = "LEADER",
		action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
	},
	{
		key = "mapped:s",
		mods = "LEADER",
		action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
	},
	{ key = "mapped:c", mods = "LEADER", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
	{ key = "mapped:V", mods = "CTRL", action = "Paste" },
	{ key = "mapped:C", mods = "CTRL", action = "Copy" },
	{ key = "mapped:h", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
	{ key = "mapped:l", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
	{ key = "mapped:k", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
	{ key = "mapped:j", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
	{ key = "mapped:q", mods = "CMD", action = "QuitApplication" },
	{ key = "mapped:w", mods = "LEADER", action = wezterm.action({ CloseCurrentPane = { confirm = false } }) },
}
for i = 1, 8 do
	-- CTRL number to activate that tab
	table.insert(mykeys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action({ ActivateTab = i - 1 }),
	})
end

return {
	leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 },
	font = wezterm.font("JetBrainsMono Nerd Font"),
	font_size = 16,
	color_scheme = "DoomOne",
	keys = mykeys,
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
}
