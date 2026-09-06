local colors = require("colors")
local mainMod = require("hyprland.binds").mainMod

if hl.plugin then
  if hl.plugin.dynamic_cursors then
    hl.config({
      plugin = {
        dynamic_cursors = {
          mode = "stretch",

          rotate = {
            length = 24,
          },

          shake = { effects = true },
        },
      },
    })
  end

  if hl.plugin.hyprbars then
    hl.config({
      plugin = {
        hyprbars = {
          bar_precedence_over_border = true,
          bar_part_of_window = true,
          bar_color = colors.surface,
          col = { text = colors.fg, },
          bar_text_size = 15,
          bar_text_font = "Adwaita Sans",
          bar_height = 20,
        },
      },
    })
  end

  if hl.plugin.scrolloverview then
    hl.plugin.scrolloverview.configure({
      wallpaper = 2,
      blur = true,
      workspace_gap = 30,
      shadow = {
        enabled = true,
      }
    })

    hl.bind(mainMod .. " + W", hl.plugin.scrolloverview.overview("toggle"))
    hl.gesture({ fingers = 3, direction = "up", action = function() hl.dispatch(hl.plugin.scrolloverview.overview("enable")) end })
    hl.gesture({ fingers = 3, direction = "down", action = function() hl.dispatch(hl.plugin.scrolloverview.overview("disable")) end })
  end
end
