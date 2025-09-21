local config = require("core.config")
local keys = require("core.keys")

return config.create({
	options = {
		keymap = {
			preset = "enter",
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide" },
			["<C-y>"] = { "select_and_accept" },

			["<C-p>"] = { "select_prev", "fallback" },
			["<C-n>"] = { "select_next", "fallback" },

			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },

			["<Tab>"] = { "snippet_forward", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "fallback" },

			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },
		},

		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			providers = {
				buffer = {
					name = "Buffer",
					module = "blink.cmp.sources.buffer",
					opts = {
						get_bufnrs = function()
							return vim.tbl_filter(function(buf)
								local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
								return byte_size < 1024 * 1024
							end, vim.api.nvim_list_bufs())
						end,
					},
				},
				snippets = {
					name = "Snippets",
					module = "blink.cmp.sources.snippets",
					opts = {
						friendly_snippets = true,
						search_paths = { vim.fn.stdpath("config") .. "/snippets" },
						global_snippets = { "all" },
						extended_filetypes = {},
						ignored_filetypes = {},
					},
				},
				path = {
					name = "Path",
					module = "blink.cmp.sources.path",
					opts = {
						trailing_slash = false,
						label_trailing_slash = true,
						get_cwd = function(context)
							return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
						end,
						show_hidden_files_by_default = false,
					},
				},
			},
		},

		completion = {
			accept = { auto_brackets = { enabled = true } },
			menu = {
				draw = {
					treesitter = { "lsp" },
					columns = {
						{ "label", "label_description", gap = 1 },
						{ "kind_icon", "kind" },
					},
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 250,
			},
			ghost_text = {
				enabled = false,
			},
		},

		signature = {
			enabled = true,
		},
	},

	setup = function(opts)
		local blink = require("blink.cmp")
		blink.setup(opts)

		keys.register({
			keys.group("<leader>c", "[C]ode"),
			{ "<C-Space>", desc = "Show Completion", mode = "i" },
			{ "<C-e>", desc = "Hide Completion", mode = "i" },
			{ "<C-y>", desc = "Accept Completion", mode = "i" },
			{ "<C-b>", desc = "Scroll Docs Up", mode = "i" },
			{ "<C-f>", desc = "Scroll Docs Down", mode = "i" },
			{ "<Tab>", desc = "Next Snippet", mode = "i" },
			{ "<S-Tab>", desc = "Previous Snippet", mode = "i" },
		})
	end,

	autocmds = {
		{
			event = "FileType",
			pattern = { "markdown", "text" },
			callback = function()
				local blink = require("blink.cmp")
				if blink and blink.setup then
				end
			end,
		},
	},

	commands = {
		BlinkToggle = {
			callback = function()
				local blink = require("blink.cmp")
				vim.notify("Blink completion toggled")
			end,
			opts = { desc = "Toggle Blink completion" },
		},
	},
})
