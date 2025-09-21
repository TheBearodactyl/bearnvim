local plugin = require("core.plugin")

return {
	plugin.spec({
		"saghen/blink.cmp",
		lazy = false,
		dependencies = "rafamadriz/friendly-snippets",
		version = "v0.*",
		opts = function()
			return require("configs.blink_cmp").options
		end,
		config = function(_, opts)
			require("configs.blink_cmp").setup(opts)
		end,
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
		opts = require("configs.nerdy").options,
	}),
}
