local plugin = require("core.plugin")

return {
	plugin.spec({
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		setup = require("configs.harpoon").setup,
		opts = require("configs.harpoon").options,
	}),

	plugin.spec({
		"folke/persistence.nvim",
		event = "BufReadPre",
		setup = require("configs.persistence").setup,
		opts = require("configs.persistence").options,
	}),

	plugin.spec({
		"nvim-tree/nvim-tree.lua",
		opts = require("configs.nvim_tree").options,
	}),
}
