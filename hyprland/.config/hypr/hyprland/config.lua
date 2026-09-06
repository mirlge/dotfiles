local colors = require("colors")

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

    layout = "scrolling",

    allow_tearing = true,

    snap = {
      enabled = true,
    },
  },

  decoration = {
    blur = {
      size = 3,
      passes = 4,
    },

    shadow = {
      range = 20,
    }
  },

  master = {
    new_status = "inherit",
  },

  misc = {
    font_family = "Adwaita Sans",

    force_default_wallpaper = 0,
    mouse_move_enables_dpms = true,
    key_press_enables_dpms = true,

    focus_on_activate = true,
  },

  group = {
    insert_after_current = false,

    col = {
      border_active = colors.accent,
      border_inactive = colors.dim,

      border_locked_active = colors.red,
      border_locked_inactive = colors.dim,
    },

    groupbar = {
      font_size = 13,
      text_color = colors.fg,
      height = 20,

      col = {
        active = colors.accent,
        inactive = colors.dim,

        locked_active = colors.red,
        locked_inactive = colors.dim,
      },
    },
  },

  xwayland = {
    force_zero_scaling = true,
  },

  ecosystem = {
    enforce_permissions = true,
  },
})
