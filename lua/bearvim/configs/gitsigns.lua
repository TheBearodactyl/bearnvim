local config = require("bearvim.core.config")

return config.create({
	options = {
		signs = {
			add = { text = "" },
			change = { text = "󰏫" },
			delete = { text = "" },
			topdelete = { text = "" },
			changedelete = { text = "" },
			untracked = { text = "󰇝" },
		},
		signs_staged = {
			add = { text = "" },
			change = { text = "󰏫" },
			delete = { text = "" },
			topdelete = { text = "" },
			changedelete = { text = "" },
			untracked = { text = "󰇝" },
		},
		signcolumn = true,
		numhl = true,
		linehl = true,
		word_diff = true,
	},

	--- @param opts Gitsigns.Config
	setup = function(opts)
		require("gitsigns").setup(opts)
	end,
})
