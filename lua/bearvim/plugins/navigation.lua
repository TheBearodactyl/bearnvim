local plugin = require("bearvim.core.plugin")

return {
	plugin.spec({
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		setup = require("bearvim.configs.harpoon").setup,
		opts = require("bearvim.configs.harpoon").options,
	}),

	plugin.spec({
		"folke/persistence.nvim",
		event = "BufReadPre",
		setup = require("bearvim.configs.persistence").setup,
		opts = require("bearvim.configs.persistence").options,
	}),

	plugin.spec({
		"nvim-tree/nvim-tree.lua",
		opts = require("bearvim.configs.nvim_tree").options,
	}),

	plugin.spec({
		"smoka7/hop.nvim",
		tag = "v2.7.2",
		opts = require("bearvim.configs.hop").options,
		setup = require("bearvim.configs.hop").setup,
		keys = require("bearvim.configs.hop").keys,
	}),
}
