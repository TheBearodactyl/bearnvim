local config = require("core.config")
local keys = require("core.keys")

return config.create({
	options = {
		max_recents = 20,
		add_default_keybindings = true,
	},
})
