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
