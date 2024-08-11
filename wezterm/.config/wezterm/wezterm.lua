local wezterm = require("wezterm")

local config = {
    font = wezterm.font("JetBrainsMono Nerd Font"),
    font_size = 16,
    color_scheme = "Catppuccin Mocha",
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },
    leader = { key = "a", mods = "CTRL" },
    hide_tab_bar_if_only_one_tab = true,
    keys = {
        { key = "a",  mods = "LEADER|CTRL",  action = wezterm.action { SendString = "\x01" } },
        { key = "-",  mods = "LEADER",       action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
        { key = "\\", mods = "LEADER",       action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
        { key = "s",  mods = "LEADER",       action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
        { key = "v",  mods = "LEADER",       action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
        { key = "o",  mods = "LEADER",       action = "TogglePaneZoomState" },
        { key = "z",  mods = "LEADER",       action = "TogglePaneZoomState" },
        { key = "c",  mods = "LEADER",       action = wezterm.action { SpawnTab = "CurrentPaneDomain" } },
        { key = "h",  mods = "LEADER",       action = wezterm.action { ActivatePaneDirection = "Left" } },
        { key = "j",  mods = "LEADER",       action = wezterm.action { ActivatePaneDirection = "Down" } },
        { key = "k",  mods = "LEADER",       action = wezterm.action { ActivatePaneDirection = "Up" } },
        { key = "l",  mods = "LEADER",       action = wezterm.action { ActivatePaneDirection = "Right" } },
        { key = "H",  mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Left", 5 } } },
        { key = "J",  mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Down", 5 } } },
        { key = "K",  mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Up", 5 } } },
        { key = "L",  mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Right", 5 } } },
        { key = "1",  mods = "LEADER",       action = wezterm.action { ActivateTab = 0 } },
        { key = "2",  mods = "LEADER",       action = wezterm.action { ActivateTab = 1 } },
        { key = "3",  mods = "LEADER",       action = wezterm.action { ActivateTab = 2 } },
        { key = "4",  mods = "LEADER",       action = wezterm.action { ActivateTab = 3 } },
        { key = "5",  mods = "LEADER",       action = wezterm.action { ActivateTab = 4 } },
        { key = "6",  mods = "LEADER",       action = wezterm.action { ActivateTab = 5 } },
        { key = "7",  mods = "LEADER",       action = wezterm.action { ActivateTab = 6 } },
        { key = "8",  mods = "LEADER",       action = wezterm.action { ActivateTab = 7 } },
        { key = "9",  mods = "LEADER",       action = wezterm.action { ActivateTab = 8 } },
        { key = "&",  mods = "LEADER|SHIFT", action = wezterm.action { CloseCurrentTab = { confirm = true } } },
        { key = "d",  mods = "LEADER",       action = wezterm.action { CloseCurrentPane = { confirm = true } } },
        { key = "x",  mods = "LEADER",       action = wezterm.action { CloseCurrentPane = { confirm = true } } },
    },
}

-- config.default_prog = { '/home/ericus/.cargo/bin/nu', '-l' }

return config
