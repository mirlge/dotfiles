local wezterm = require("wezterm")
local config = wezterm.config_builder()

local theme_plugin = wezterm.plugin.require("https://github.com/neapsix/wezterm")
config.colors = theme_plugin.main.colors()

config.font_size = 12
config.adjust_window_size_when_changing_font_size = false

config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

return config
