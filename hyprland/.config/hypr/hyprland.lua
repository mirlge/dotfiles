local colors = require("colors")

require("monitors")
require("workspaces")

hl.on("hyprland.start", function()
  hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic 24")

  hl.exec_cmd("dbus-update-activation-environment --systemd --all")
  hl.exec_cmd("systemctl --user import-environment QT_QPA_PLATFORMTHEME")

  hl.exec_cmd("~/.config/hypr/scripts/autostart.sh")
end)

hl.config({
  input = {
    kb_layout = "us,se",
    kb_variant = "altgr-weur,",
    kb_options = "fkeys:basic_13-24,fkeys:basic_13-24",

    numlock_by_default = true,

    touchpad = {
      natural_scroll = true,
      disable_while_typing = false,
    },
  },

  general = {
    gaps_out = 10,

    border_size = 2,
    col = {
      active_border = colors.primary,
      inactive_border = colors.outline,
    },

    layout = "scrolling",

    allow_tearing = true,

    snap = {
      enabled = true,
    },
  },

  decoration = {
    blur = {
      enabled = false,
    },
  },

  --[[ TODO: Convert this
animations {
    bezier = myBezier, 0.05, 0.9, 0.1, 1.05

    animation = windows, 1, 7, myBezier
    animation = windowsOut, 1, 7, myBezier, popin 80%
    animation = border, 0
    animation = borderangle, 0
    animation = workspaces, 1, 2, default, fade
}
]]

  master = {
    new_status = "inherit",
  },

  misc = {
    font_family = "Adwaita Sans",

    force_default_wallpaper = 0,
    mouse_move_enables_dpms = true,
    key_press_enables_dpms = true,

    enable_swallow = true,
    swallow_regex = "^(kitty|org.wezfurlong.wezterm|com.mitchellh.ghostty)$",
    swallow_exception_regex = "^(wev)$",

    focus_on_activate = true,
  },

  group = {
    insert_after_current = false,

    col = {
      border_active = colors.primary,
      border_inactive = colors.outline,

      border_locked_active = colors.error,
      border_locked_inactive = colors.outline,
    },

    groupbar = {
      font_size = 13,
      text_color = colors.on_primary,
      height = 20,

      col = {
        active = colors.primary,
        inactive = colors.outline,

        locked_active = colors.error,
        locked_inactive = colors.outline,
      },
    },
  },

  xwayland = {
    force_zero_scaling = true,
  },

  ecosystem = {
    enforce_permissions = true,
  },

  plugin = {
    hy3 = {
      tab_first_window = true,
      tabs = {
        height = 18,
        padding = 0,
        radius = 0,

        colors = {
          active = colors.primary,
          active_border = colors.primary,
          active_text = colors.on_primary,

          inactive = colors.outline,
          inactive_border = colors.outline,

          active_alt_monitor = colors.source_color,
          active_alt_monitor_border = colors.source_color,

          focused = colors.source_color,
          focused_border = colors.source_color,
        },

        text_font = "Adwaita Sans",
        text_height = 11,
      },
    },
    dynamic_cursors = {
      mode = "rotate",

      rotate = {
        length = 24,
      },
    },
  },
})

hl.window_rule({
  name = "xwayland-video-bridge-fixes",
  match = { class = "xwaylandvideobridge" },

  no_initial_focus = true,
  no_focus = true,
  no_anim = true,
  no_blur = true,
  max_size = "1 1",
  opacity = 0.0,
})

hl.window_rule({
  name = "picture-in-picture",
  match = { title = "^(Picture[- ]in[- ][Pp]icture)$" },

  float = true,
  pin = true,
})

hl.window_rule({ match = { class = "^(ulauncher)$" }, border_size = 0 })

hl.permission({ binary = "/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", type = "screencopy", mode = "allow" })
hl.permission({ binary = "/usr/bin/hyprlock", type = "screencopy", mode = "allow" })
hl.permission({ binary = "/usr/bin/wl-kbptr", type = "screencopy", mode = "allow" })

local mainMod = "SUPER"
local hy3 = hl.plugin.hy3

-- Application launch keybinds
hl.bind(mainMod .. "+ return", hl.dsp.exec_cmd("uwsm app -- ghostty"))
hl.bind(mainMod .. "+ F", hl.dsp.exec_cmd("uwsm app -- nautilus"))
hl.bind(mainMod .. "+ B", hl.dsp.exec_cmd("uwsm app -- zen-browser"))
hl.bind(mainMod .. "+ V", hl.dsp.exec_cmd("clipman pick --tool=rofi"))
hl.bind(mainMod .. "+ S", hl.dsp.exec_cmd("wlr-which-key -k s"))
hl.bind("PRINT", hl.dsp.exec_cmd("uwsm app -- flameshot gui"))

-- Launcher keybinds
hl.bind(mainMod .. "+ D", hl.dsp.exec_cmd("rofi -show combi"))
hl.bind(mainMod .. "+ R", hl.dsp.exec_cmd("walker"))
hl.bind(mainMod .. "+ tab", hl.dsp.exec_cmd("rofi -show window"))

-- Window mainpulation keybinds
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + space", hl.dsp.window.float())
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + P", hl.dsp.window.pin())

-- Compositor keybinds
hl.bind(mainMod .. " + CTRL + Q", hl.dsp.exec_cmd("uwsm stop"))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.exec_cmd("loginctl lock-session"))

-- Move focus with mainMod + [hjkl]
hl.bind(mainMod .. " + H", hl.dsp.layout("focus l"))
hl.bind(mainMod .. " + J", hl.dsp.layout("focus d"))
hl.bind(mainMod .. " + K", hl.dsp.layout("focus u"))
hl.bind(mainMod .. " + L", hl.dsp.layout("focus r"))

-- Switch focused monitor with mainMod + [ or mainMod + ]
hl.bind(mainMod .. " + bracketright", hl.dsp.focus({ monitor = "+1" }))
hl.bind(mainMod .. " + bracketleft", hl.dsp.focus({ monitor = "-1" }))

hl.bind(mainMod .. " + space", hl.dsp.window.cycle_next({ floating = not (hl.get_active_window().floating or false) }))

-- Move window
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "d" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "r" }))

hl.bind(mainMod .. " + period", hl.dsp.layout("promote"))

-- Move column
hl.bind(mainMod .. " + SHIFT + bracketleft", hl.dsp.layout("swapcol l"))
hl.bind(mainMod .. " + SHIFT + bracketright", hl.dsp.layout("swapcol r"))

-- Switch workspaces with mainMod + [0-9]
for i = 1, 9 do
  hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
end
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 9 do
  hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = "10" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- volume buttons
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume raise"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume lower"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"))
hl.bind("ALT + XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --input-volume raise"))
hl.bind("ALT + XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --input-volume lower"))
hl.bind("ALT + XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bind("ALT + XF86AudioMute", hl.dsp.exec_cmd("swayosd-client --input-volume mute-toggle"))

-- brightness buttons
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("swayosd-client --brightness raise"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("swayosd-client --brightness lower"))

-- keyboard backlight buttons
hl.bind("XF86KbdBrightnessUp", hl.dsp.exec_cmd("lightctl -D smc::kbd_backlight +"))
hl.bind("XF86KbdBrightnessDown", hl.dsp.exec_cmd("lightctl -D smc::kbd_backlight -"))

-- media buttons
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(mainMod .. " + F", hl.dsp.layout("colresize 1.0"))
hl.bind(mainMod .. " + Equal", hl.dsp.layout("colresize +conf"))
hl.bind(mainMod .. " + Minus", hl.dsp.layout("colresize -conf"))

-- Resize/move submap
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
  hl.bind("H", hl.dsp.window.resize({ x = "-10", y = "0" }))
  hl.bind("J", hl.dsp.window.resize({ x = "0", y = "10" }))
  hl.bind("K", hl.dsp.window.resize({ x = "0", y = "-10" }))
  hl.bind("L", hl.dsp.window.resize({ x = "10", y = "0" }))

  hl.bind("SHIFT + H", hl.dsp.window.move({ direction = "l" }))
  hl.bind("SHIFT + J", hl.dsp.window.move({ direction = "d" }))
  hl.bind("SHIFT + K", hl.dsp.window.move({ direction = "u" }))
  hl.bind("SHIFT + L", hl.dsp.window.move({ direction = "r" }))

  hl.bind("escape", hl.dsp.submap("reset"))
end)

-- Clean submap
hl.bind(mainMod .. " + CTRL + SHIFT + L", hl.dsp.submap("reset"))
hl.define_submap("clean", function()
  hl.bind(mainMod .. " + CTRL + SHIFT + escape", hl.dsp.submap("reset"))
end)

hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("wlr-which-key -k c"))

-- hyprkool start --
-- Basic movement between and within activities
hl.bind(mainMod .. " + ALT + bracketright", hl.dsp.exec_cmd("hyprkool next-activity -c"))
hl.bind(mainMod .. " + ALT + bracketleft", hl.dsp.exec_cmd("hyprkool prev-activity -c"))
hl.bind(mainMod .. " + ALT + SHIFT + bracketright", hl.dsp.exec_cmd("hyprkool next-activity -c -w"))
hl.bind(mainMod .. " + ALT + SHIFT + bracketleft", hl.dsp.exec_cmd("hyprkool prev-activity -c -w"))
hl.bind(mainMod .. " + ALT + h", hl.dsp.exec_cmd("hyprkool move-left -c"))
hl.bind(mainMod .. " + ALT + l", hl.dsp.exec_cmd("hyprkool move-right -c"))
hl.bind(mainMod .. " + ALT + j", hl.dsp.exec_cmd("hyprkool move-down -c"))
hl.bind(mainMod .. " + ALT + k", hl.dsp.exec_cmd("hyprkool move-up -c"))
hl.bind(mainMod .. " + ALT + SHIFT + h", hl.dsp.exec_cmd("hyprkool move-left -cw"))
hl.bind(mainMod .. " + ALT + SHIFT + l", hl.dsp.exec_cmd("hyprkool move-right -cw"))
hl.bind(mainMod .. " + ALT + SHIFT + j", hl.dsp.exec_cmd("hyprkool move-down -cw"))
hl.bind(mainMod .. " + ALT + SHIFT + k", hl.dsp.exec_cmd("hyprkool move-up -cw"))

-- Easy switching/moving windows between activities
hl.bind(mainMod .. " + ALT + 1", hl.dsp.exec_cmd("hyprkool switch-to-activity -n A1"))
hl.bind(mainMod .. " + ALT + 2", hl.dsp.exec_cmd("hyprkool switch-to-activity -n A2"))
hl.bind(mainMod .. " + ALT + 3", hl.dsp.exec_cmd("hyprkool switch-to-activity -n A3"))
hl.bind(mainMod .. " + ALT + 4", hl.dsp.exec_cmd("hyprkool switch-to-activity -n A4"))
hl.bind(mainMod .. " + ALT + 5", hl.dsp.exec_cmd("hyprkool switch-to-activity -n A5"))
hl.bind(mainMod .. " + ALT + 6", hl.dsp.exec_cmd("hyprkool switch-to-activity -n A6"))
hl.bind(mainMod .. " + ALT + 7", hl.dsp.exec_cmd("hyprkool switch-to-activity -n A7"))
hl.bind(mainMod .. " + ALT + 8", hl.dsp.exec_cmd("hyprkool switch-to-activity -n A8"))
hl.bind(mainMod .. " + ALT + 9", hl.dsp.exec_cmd("hyprkool switch-to-activity -n A9"))
hl.bind(mainMod .. " + ALT + SHIFT + 1", hl.dsp.exec_cmd("hyprkool switch-to-activity -wn A1"))
hl.bind(mainMod .. " + ALT + SHIFT + 2", hl.dsp.exec_cmd("hyprkool switch-to-activity -wn A2"))
hl.bind(mainMod .. " + ALT + SHIFT + 3", hl.dsp.exec_cmd("hyprkool switch-to-activity -wn A3"))
hl.bind(mainMod .. " + ALT + SHIFT + 4", hl.dsp.exec_cmd("hyprkool switch-to-activity -wn A4"))
hl.bind(mainMod .. " + ALT + SHIFT + 5", hl.dsp.exec_cmd("hyprkool switch-to-activity -wn A5"))
hl.bind(mainMod .. " + ALT + SHIFT + 6", hl.dsp.exec_cmd("hyprkool switch-to-activity -wn A6"))
hl.bind(mainMod .. " + ALT + SHIFT + 7", hl.dsp.exec_cmd("hyprkool switch-to-activity -wn A7"))
hl.bind(mainMod .. " + ALT + SHIFT + 8", hl.dsp.exec_cmd("hyprkool switch-to-activity -wn A8"))
hl.bind(mainMod .. " + ALT + SHIFT + 9", hl.dsp.exec_cmd("hyprkool switch-to-activity -wn A9"))
-- hyprkool end --

hl.bind(mainMod .. " + CTRL + space", hl.dsp.exec_cmd("hyprctl switchxkblayout keyd-virtual-keyboard next"))

-- gestures
hl.gesture({ fingers = 3, direction = "left", action = function() hl.exec_cmd("hyprkool move-right -c") end })
hl.gesture({ fingers = 3, direction = "down", action = function() hl.exec_cmd("hyprkool move-up -c") end })
hl.gesture({ fingers = 3, direction = "up", action = function() hl.exec_cmd("hyprkool move-down -c") end })
hl.gesture({ fingers = 3, direction = "right", action = function() hl.exec_cmd("hyprkool move-left -c") end })

hl.gesture({ fingers = 4, direction = "right", action = function() hl.exec_cmd("hyprkool prev-activity -c") end })
hl.gesture({ fingers = 4, direction = "left", action = function() hl.exec_cmd("hyprkool next-activity -c") end })

--[[
gesture = 4, up, dispatcher, overview:close
gesture = 4, down, dispatcher, overview:open
]]
