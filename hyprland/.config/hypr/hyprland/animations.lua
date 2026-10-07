hl.curve("spatial", { type = "spring", mass = 1, stiffness = 250, dampening = 30 })
hl.curve("effects", { type = "spring", mass = 1, stiffness = 1600, dampening = 80 })

hl.animation({ leaf = "layersIn", enabled = true, speed = 2.5, bezier = "default" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 100, bezier = "default" })
hl.layer_rule({ match = { namespace = "swaync-control-center" }, animation = "slide right" })

hl.animation({ leaf = "workspaces", enabled = true, speed = 5, spring = "spatial", style = "slidevert" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3.5, spring = "spatial", style = "slidevert" })

hl.animation({ leaf = "windows", enabled = true, speed = 5, spring = "spatial" })

hl.animation({ leaf = "fade", enabled = true, speed = 2, spring = "effects" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 2, spring = "spatial" })
