hl.curve("spatial", { type = "spring", mass = 1, stiffness = 250, dampening = 30 })
hl.curve("effects", { type = "spring", mass = 1, stiffness = 1600, dampening = 80 })

hl.animation({ leaf = "layersIn", enabled = true, speed = 2.5, bezier = "default" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 100, bezier = "default" })
hl.layer_rule({ match = { namespace = "swaync-control-center" }, animation = "slide right" })

hl.animation({ leaf = "workspaces", enabled = true, speed = 8, bezier = "default", style = "slidevert" })
