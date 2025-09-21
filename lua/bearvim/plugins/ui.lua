local plugin = require("bearvim.core.plugin")
local keys = require("bearvim.core.keys")

return {
	plugin.spec({
		"folke/which-key.nvim",
		event = "VimEnter",
		setup = require("bearvim.configs.which_key").setup,
		opts = require("bearvim.configs.which_key").options,
	}),

	plugin.spec({
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		setup = require("bearvim.configs.lualine").setup,
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
		setup = require("bearvim.configs.barbar").setup,
		opts = require("bearvim.configs.barbar").options,
		version = "^1.0.0",
	}),

	plugin.spec({
		"catppuccin/nvim",
		name = "catppuccin",
		setup = function()
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	}),

	plugin.spec({
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		setup = require("bearvim.configs.snacks").setup,
		opts = require("bearvim.configs.snacks").options,
	}),

	plugin.spec({
		"folke/trouble.nvim",
		cmd = "Trouble",
		setup = require("bearvim.configs.trouble").setup,
		opts = require("bearvim.configs.trouble").options,
		keys = require("bearvim.configs.trouble").keys,
	}),

	plugin.spec({
		"j-hui/fidget.nvim",
		opts = require("bearvim.configs.fidget").options,
	}),

	plugin.spec({
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = require("bearvim.configs.alpha").setup,
	}),

	plugin.spec({ "rktjmp/lush.nvim" }),
	plugin.spec({ "rktjmp/shipwright.nvim" }),
}
