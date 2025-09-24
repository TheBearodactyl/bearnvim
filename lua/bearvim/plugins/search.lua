local plugin = require("bearvim.core.plugin")

return {
	plugin.spec({
		"ibhagwan/fzf-lua",
		event = "VimEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = require("bearvim.configs.fzf").options,
		setup = require("bearvim.configs.fzf").setup,
	}),
}
