local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "iris"

config.font_size = 12
config.adjust_window_size_when_changing_font_size = false

config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

return config
