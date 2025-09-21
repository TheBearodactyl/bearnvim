local config = require("core.config")
local keys = require("core.keys")

return config.create({
	options = {
		options = {
			icons_enabled = vim.g.have_nerd_font,
			theme = "catppuccin-mocha",
			component_separators = "|",
			section_separators = "",
			globalstatus = true,
		},
	},

	setup = function(opts)
		require("lualine").setup(opts)

		keys.register({
			keys.group("<leader>T", "[T]oggle"),
			{
				"<leader>Ts",
				function()
					if vim.opt.laststatus:get() == 0 then
						vim.opt.laststatus = 3
						vim.notify("Statusline enabled", vim.log.levels.INFO)
					else
						vim.opt.laststatus = 0
						vim.notify("Statusline disabled", vim.log.levels.INFO)
					end
				end,
				desc = "[T]oggle [S]tatusline",
			},
		})
	end,
})
