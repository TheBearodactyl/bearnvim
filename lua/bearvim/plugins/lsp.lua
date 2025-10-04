local plugin = require("bearvim.core.plugin")

return {
	plugin.spec({
		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>pm", "<cmd>Mason<cr>", desc = "[P]lugin [M]ason" } },
		build = ":MasonUpdate",
		setup = require("bearvim.configs.mason").setup,
		opts = require("bearvim.configs.mason").options,
	}),

	plugin.spec({
		"williamboman/mason-lspconfig.nvim",
	}),

	plugin.spec({
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		setup = require("bearvim.configs.lspconfig").setup,
		opts = require("bearvim.configs.lspconfig").options,
	}),

	plugin.spec({
		"smjonas/inc-rename.nvim",
		opts = {},
		keys = require("bearvim.configs.inc_rename").keys,
		setup = require("bearvim.configs.inc_rename").setup,
	}),

	plugin.spec({
		"folke/lazydev.nvim",
		ft = "lua",
		opts = require("bearvim.configs.lazydev").options,
		setup = require("bearvim.configs.lazydev").setup,
	}),

	plugin.spec({
		"b0o/schemastore.nvim",
		event = "VimEnter",
		priority = 1000,
	}),

	plugin.spec({
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		lazy = false,
		opts = require("bearvim.configs.refactoring").options,
		setup = require("bearvim.configs.refactoring").setup,
	}),
}
