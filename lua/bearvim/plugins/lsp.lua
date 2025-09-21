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
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		setup = require("bearvim.configs.lspconfig").setup,
		opts = require("bearvim.configs.lspconfig").options,
	}),

	plugin.spec({
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
	}),
}
