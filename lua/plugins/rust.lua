local plugin = require("core.plugin")

return {
	plugin.spec({
		"saecki/crates.nvim",
		tag = "stable",
		dependencies = { "nvim-lua/plenary.nvim" },
		ft = { "toml" },
		setup = require("configs.crates").setup,
		opts = require("configs.crates").options,
	}),

	plugin.spec({
		"mrcjkb/rustaceanvim",
		version = "^6",
		lazy = false,
		ft = { "rust" },
		setup = require("configs.rustaceanvim").setup,
		opts = require("configs.rustaceanvim").options,
	}),
}
