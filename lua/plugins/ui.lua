local plugin = require("core.plugin")
local keys = require("core.keys")

return {
	plugin.spec({
		"folke/which-key.nvim",
		event = "VimEnter",
		setup = require("configs.which_key").setup,
		opts = require("configs.which_key").options,
	}),

	plugin.spec({
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		setup = require("configs.lualine").setup,
	}),

	plugin.spec({
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	}),

	plugin.spec({
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	}),

	plugin.spec({
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		setup = require("configs.barbar").setup,
		opts = require("configs.barbar").options,
		version = "^1.0.0",
	}),

	plugin.spec({
		"catppuccin/nvim",
		name = "catppuccin",
		setup = function()
			vim.cmd.colorscheme("catppuccin-macchiato")
		end,
	}),

	plugin.spec({
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		setup = require("configs.snacks").setup,
		opts = require("configs.snacks").options,
	}),

	plugin.spec({
		"folke/trouble.nvim",
		cmd = "Trouble",
		setup = require("configs.trouble").setup,
		opts = require("configs.trouble").options,
	}),

	plugin.spec({
		"j-hui/fidget.nvim",
		opts = require("configs.fidget").options,
	}),
}
