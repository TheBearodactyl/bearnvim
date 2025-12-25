local plugin = require("bearvim.core.plugin")

return {
	plugin.spec({
		"saghen/blink.cmp",
		lazy = false,
		dependencies = {
			"rafamadriz/friendly-snippets",
			"mikavilpas/blink-ripgrep.nvim",
			"MahanRahmati/blink-nerdfont.nvim",
		},
		version = "v1.8.0",
		opts = require("bearvim.configs.blink_cmp").options,
		setup = require("bearvim.configs.blink_cmp").setup,
	}),

	plugin.spec({
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	}),
}
