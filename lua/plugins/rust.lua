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
		version = "6.9.2",
		lazy = false,
		ft = { "rust" },
		opts = require("configs.rustaceanvim").options,
		keys = require("configs.rustaceanvim").keys,
	}),
}
