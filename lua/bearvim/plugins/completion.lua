local plugin = require("bearvim.core.plugin")

return {
	plugin.spec({
		"saghen/blink.cmp",
		lazy = false,
		dependencies = "rafamadriz/friendly-snippets",
		version = "v1.7.0",
		opts = require("bearvim.configs.blink_cmp").options,
		setup = require("bearvim.configs.blink_cmp").setup,
	}),

	plugin.spec({
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	}),

	plugin.spec({
		"2kabhishek/nerdy.nvim",
		dependencies = { "folke/snacks.nvim" },
		cmd = "Nerdy",
		opts = require("bearvim.configs.nerdy").options,
	}),
}
