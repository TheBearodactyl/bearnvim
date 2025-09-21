local plugin = require("bearvim.core.plugin")

return {
	plugin.spec({
		"folke/trouble.nvim",
		opts = require("bearvim.configs.trouble").options,
		keys = require("bearvim.configs.trouble").keys,
		setup = require("bearvim.configs.trouble").setup,
		cmd = "Trouble",
	}),

	plugin.spec({
		"code-biscuits/nvim-biscuits",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = require("bearvim.configs.biscuits").options,
		setup = require("bearvim.configs.biscuits").setup,
	}),
}
