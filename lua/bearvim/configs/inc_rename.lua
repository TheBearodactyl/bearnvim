local config = require("bearvim.core.config")
local keys = require("bearvim.core.keys")

return config.create({

	setup = function(opts)
		keys.register({
			{
				"<leader>cR",
				"<cmd>IncRename<cr>",
				desc = "Incrementaly Rename Symbol",
			},
		})
	end,

	keys = {
		{ "<leader>cR", desc = "Incrementaly Rename Symbol" },
	},
})
