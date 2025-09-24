local config = require("bearvim.core.config")
local keys = require("bearvim.core.keys")

return config.create({
	options = {},
	setup = function(opts)
		require("fzf-lua").setup(opts)
	end,
})
