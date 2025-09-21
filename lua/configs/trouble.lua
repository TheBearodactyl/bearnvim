local config = require("core.config")
local keys = require("core.keys")

return config.create({
	options = {
		modes = {
			test = {
				mode = "diagnostics",
				preview = {
					type = "split",
					relative = "win",
					position = "right",
					size = 0.3,
				},
			},
		},
	},

	setup = function(opts)
		require("trouble").setup(opts)

		keys.register({
			keys.group("<leader>x", "Trouble"),
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
			{ "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
			{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
		})
	end,

	keys = {
		{ "<leader>x", group = "Trouble" },
		{ "<leader>xx", desc = "Diagnostics (Trouble)" },
		{ "<leader>xX", desc = "Buffer Diagnostics (Trouble)" },
		{ "<leader>cs", desc = "Symbols (Trouble)" },
		{ "<leader>cl", desc = "LSP Definitions / references / ... (Trouble)" },
		{ "<leader>xL", desc = "Location List (Trouble)" },
		{ "<leader>xQ", desc = "Quickfix List (Trouble)" },
	},
})
