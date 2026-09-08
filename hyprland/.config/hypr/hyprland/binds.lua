local M = {
  mainMod = "SUPER"
}

function M:setup()
  local mainMod = self.mainMod

  -- Application launch keybinds
  hl.bind(mainMod .. "+ return", hl.dsp.exec_cmd("uwsm app -- ghostty"))
  hl.bind(mainMod .. "+ B", hl.dsp.exec_cmd("uwsm app -- zen-browser"))
  hl.bind(mainMod .. "+ V", hl.dsp.exec_cmd("uwsm app -- clipman pick --tool=rofi"))
  hl.bind(mainMod .. "+ S", hl.dsp.exec_cmd("uwsm app -- wlr-which-key -k s"))
  hl.bind("PRINT", hl.dsp.exec_cmd("uwsm app -- flameshot gui"))
  hl.bind(mainMod .. "+ N", hl.dsp.exec_cmd("qs -c mirge ipc call controls toggle"))

  -- Launcher keybinds
  hl.bind(mainMod .. "+ D", hl.dsp.exec_cmd("uwsm app -- rofi -show combi"))
  hl.bind(mainMod .. "+ R", hl.dsp.exec_cmd("uwsm app -- walker"))
  hl.bind(mainMod .. "+ tab", hl.dsp.exec_cmd("uwsm app -- rofi -show window"))

  -- Window mainpulation keybinds
  hl.bind(mainMod .. " + Q", hl.dsp.window.close())
  hl.bind(mainMod .. " + SHIFT + space", hl.dsp.window.float())
  hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen())
  hl.bind(mainMod .. " + P", hl.dsp.window.pin())

  -- Compositor keybinds
  hl.bind(mainMod .. " + CTRL + Q", hl.dsp.exec_cmd("uwsm stop"))
  hl.bind(mainMod .. " + CTRL + L", hl.dsp.exec_cmd("loginctl lock-session"))
  hl.bind(mainMod .. " + CTRL + R", hl.dsp.exec_cmd("wlr-which-key -k r"))

  -- Move focus with mainMod + [hjkl]
  hl.bind(mainMod .. " + H", hl.dsp.layout("focus l"))
  hl.bind(mainMod .. " + J", hl.dsp.layout("focus d"))
  hl.bind(mainMod .. " + K", hl.dsp.layout("focus u"))
  hl.bind(mainMod .. " + L", hl.dsp.layout("focus r"))

  -- Switch focused monitor with mainMod + [ or mainMod + ]
  hl.bind(mainMod .. " + bracketright", hl.dsp.focus({ monitor = "+1" }))
  hl.bind(mainMod .. " + bracketleft", hl.dsp.focus({ monitor = "-1" }))

  hl.bind(
    mainMod .. " + space",
    function()
      local floating = hl.get_active_window().floating
      hl.dispatch(hl.dsp.window.cycle_next({ floating = floating == nil or not floating }))
    end
  )

  -- Move window
  hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
  hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "d" }))
  hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
  hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "r" }))

  hl.bind(mainMod .. " + period", hl.dsp.layout("promote"))
  hl.bind(mainMod .. " + semicolon", hl.dsp.layout("consume_or_expel prev"))
  hl.bind(mainMod .. " + apostrophe", hl.dsp.layout("consume_or_expel next"))

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

  -- special workspaces
  hl.bind(mainMod .. " + M", hl.dsp.workspace.toggle_special("magic"))
  hl.bind(mainMod .. " + SHIFT + M", hl.dsp.window.move({ workspace = "special:magic" }))
  ---Create toggle and move to special workspace keybinds
  ---@param key string|integer
  local function special_ws(key)
    hl.bind(mainMod .. " + ALT + " .. key, hl.dsp.workspace.toggle_special(key))
    hl.bind(mainMod .. " + ALT + SHIFT + " .. key, hl.dsp.window.move({ workspace = "special:" .. key }))
  end
  for i = 0, 9 do
    special_ws(i)
  end
  for _, key in ipairs({ "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "grave", "less", "comma", "period", "slash", "equal", "minus", "backslash", "bracketleft", "bracketright", "apostrophe", "semicolon" }) do
    special_ws(key)
  end

  -- volume buttons
  hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume raise"))
  hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume lower"))
  hl.bind("XF86AudioMute", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"))
  hl.bind("ALT + XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --input-volume raise"))
  hl.bind("ALT + XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --input-volume lower"))
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
    hl.bind("H", hl.dsp.window.resize({ x = "-10", y = "0", relative = true }))
    hl.bind("J", hl.dsp.window.resize({ x = "0", y = "10", relative = true }))
    hl.bind("K", hl.dsp.window.resize({ x = "0", y = "-10", relative = true }))
    hl.bind("L", hl.dsp.window.resize({ x = "10", y = "0", relative = true }))

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

  hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("uwsm app -- wlr-which-key -k c"))
  hl.bind(mainMod .. " + CTRL + space", hl.dsp.exec_cmd("hyprctl switchxkblayout keyd-virtual-keyboard next"))

  -- Game mode
  hl.bind(mainMod .. " + G", function ()
    local game_mode = (hl.get_config("animations.enabled") == false)

    if game_mode then
      hl.exec_cmd("hyprctl reload")
      return
    end

    hl.config({
      general = {
        gaps_in = 0,
        gaps_out = 0,
        border_size = 0,
      },

      animations = {
        enabled = false, -- Disable animations
      },

      -- Disable blur, shadow and window rounding
      decoration = {
        shadow = { enabled = false },
        blur = { enabled = false },
        rounding = 0,
      }
    })
  end)
end

return M
