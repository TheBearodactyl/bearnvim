local plugin = require("bearvim.core.plugin")

return {
	plugin.spec({
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		opts = require("bearvim.configs.noice").options,
		setup = require("bearvim.configs.noice").setup,
	}),

	plugin.spec({
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		setup = require("bearvim.configs.snacks").setup,
		opts = require("bearvim.configs.snacks").options,
	}),

	plugin.spec({
		"2kabhishek/nerdy.nvim",
		dependencies = { "folke/snacks.nvim" },
		cmd = "Nerdy",
		opts = require("bearvim.configs.nerdy").options,
	}),

	plugin.spec({
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	}),

	plugin.spec({
		"m4xshen/hardtime.nvim",
		enabled = false,
		lazy = false,
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = require("bearvim.configs.hardtime").options,
		setup = require("bearvim.configs.hardtime").setup,
	}),

	plugin.spec({ "rktjmp/lush.nvim" }),
	plugin.spec({ "rktjmp/shipwright.nvim" }),
}
