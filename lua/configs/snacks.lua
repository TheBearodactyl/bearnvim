local config = require("core.config")
local keys = require("core.keys")

return config.create({
	options = {
		bigfile = { enabled = true },
		bufdelete = { enabled = true },
		dashboard = { enabled = false },
		debug = { enabled = false },
		git = { enabled = true },
		gitbrowse = { enabled = true },
		lazygit = { enabled = true },
		notify = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		rename = { enabled = true },
		statuscolumn = { enabled = true },
		terminal = { enabled = true },
		toggle = { enabled = true },
		win = { enabled = true },
		words = { enabled = true },
		zen = { enabled = true },
	},

	setup = function(opts)
		require("snacks").setup(opts)

		keys.register({
			keys.group("<leader>s", "[S]nacks"),
			{
				"<leader>sg",
				function()
					Snacks.lazygit()
				end,
				desc = "[S]nacks Lazy[G]it",
			},
			{
				"<leader>sb",
				function()
					Snacks.git.blame_line()
				end,
				desc = "[S]nacks Git [B]lame",
			},
			{
				"<leader>sB",
				function()
					Snacks.gitbrowse()
				end,
				desc = "[S]nacks Git [B]rowse",
			},
			{
				"<leader>sf",
				function()
					Snacks.lazygit.log_file()
				end,
				desc = "[S]nacks Git [F]ile Log",
			},
			{
				"<leader>sl",
				function()
					Snacks.lazygit.log()
				end,
				desc = "[S]nacks Git [L]og",
			},
			{
				"<leader>st",
				function()
					Snacks.terminal()
				end,
				desc = "[S]nacks [T]erminal",
			},
			{
				"<leader>sT",
				function()
					Snacks.terminal.toggle()
				end,
				desc = "[S]nacks [T]erminal Toggle",
			},
			{
				"<leader>sr",
				function()
					Snacks.rename.rename_file()
				end,
				desc = "[S]nacks [R]ename File",
			},
			{
				"<leader>sz",
				function()
					Snacks.zen()
				end,
				desc = "[S]nacks [Z]en Mode",
			},
			{
				"<leader>sZ",
				function()
					Snacks.zen.zoom()
				end,
				desc = "[S]nacks [Z]oom",
			},
			{
				"<leader>sn",
				function()
					Snacks.notifier.show_history()
				end,
				desc = "[S]nacks [N]otifications",
			},
			{
				"<leader>sw",
				function()
					Snacks.words.jump(vim.v.count1)
				end,
				desc = "[S]nacks [W]ords Jump",
			},
		})
	end,
})
