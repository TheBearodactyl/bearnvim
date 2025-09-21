local plugin = require("core.plugin")

return {
	plugin.spec({
		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>pm", "<cmd>Mason<cr>", desc = "[P]lugin [M]ason" } },
		build = ":MasonUpdate",
		setup = require("configs.mason").setup,
		opts = require("configs.mason").options,
	}),

	plugin.spec({
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		setup = require("configs.lspconfig").setup,
		opts = require("configs.lspconfig").options,
	}),

	plugin.spec({
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		setup = require("configs.telescope").setup,
		opts = require("configs.telescope").options,
	}),

	plugin.spec({
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
	}),

	plugin.spec({
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		setup = require("configs.telescope").setup,
		opts = require("configs.telescope").options,
	}),
}
