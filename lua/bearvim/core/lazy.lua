local M = {}

function M.bootstrap()
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not (vim.uv or vim.loop).fs_stat(lazypath) then
		local lazyrepo = "https://github.com/folke/lazy.nvim.git"
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"--branch=stable",
			lazyrepo,
			lazypath,
		})
	end
	vim.opt.rtp:prepend(lazypath)
end

function M.setup()
	M.bootstrap()

	require("lazy").setup({
		spec = {
			{ import = "bearvim.plugins" },
		},
		defaults = {
			lazy = false,
			version = false,
		},
		install = {
			colorscheme = { "rose-pine", "tokyonight", "catppuccin", "habamax" },
			missing = true,
		},
		checker = {
			enabled = true,
			notify = false,
		},
		change_detection = {
			enabled = true,
			notify = false,
		},
		performance = {
			rtp = {
				disabled_plugins = {
					"gzip",
					"matchit",
					"matchparen",
					"netrwPlugin",
					"tarPlugin",
					"tohtml",
					"tutor",
					"zipPlugin",
				},
			},
		},
		ui = {
			border = "rounded",
			backdrop = 60,
			icons = {
				cmd = " ",
				config = "",
				event = " ",
				ft = " ",
				init = " ",
				import = " ",
				keys = " ",
				lazy = "💤 ",
				loaded = "●",
				not_loaded = "○",
				plugin = " ",
				runtime = " ",
				require = "󰢱 ",
				source = " ",
				start = " ",
				task = "✔ ",
				list = {
					"●",
					"➜",
					"★",
					"‒",
				},
			},
		},
		dev = {
			path = "~/projects",
			patterns = {},
			fallback = false,
		},
		profiling = {
			loader = false,
			require = false,
		},
	})
end

function M.create_commands()
	vim.api.nvim_create_user_command("LazyHealth", function()
		vim.cmd("Lazy health")
	end, { desc = "Run Lazy health check" })

	vim.api.nvim_create_user_command("LazyProfile", function()
		vim.cmd("Lazy profile")
	end, { desc = "Show Lazy profile" })

	vim.api.nvim_create_user_command("LazyDev", function()
		require("lazy").reload()
		vim.notify("Plugins reloaded!")
	end, { desc = "Reload lazy plugins" })
end

function M.init()
	M.setup()
	M.create_commands()
end

return M
