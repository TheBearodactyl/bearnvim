local config = require("core.config")

return config.create({
	setup = function(opts)
		require("alpha").setup(require("startscreen").config)
	end,
})
