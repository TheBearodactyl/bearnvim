local config = require("bearvim.core.config")
local keys = require("bearvim.core.keys")

return config.create({
	options = {
		diagnostics = {
			underline = true,
			update_in_insert = false,
			virtual_text = {
				spacing = 4,
				source = "if_many",
				prefix = "●",
			},
			severity_sort = true,
		},
		inlay_hints = { enabled = true },
		codelens = { enabled = false },
		document_highlight = { enabled = true },
		capabilities = {},
		format = {
			formatting_options = nil,
			timeout_ms = nil,
		},
		servers = {
			lua_ls = {
				settings = {
					Lua = {
						workspace = { checkThirdParty = false },
						codeLens = { enable = true },
						completion = { callSnippet = "Replace" },
						diagnostics = { globals = { "vim" } },
					},
				},
			},
			pyright = {
				settings = {
					python = {
						analysis = { typeCheckingMode = "basic" },
					},
				},
			},
			rust_analyzer = {
				settings = {
					["rust-analyzer"] = {
						cargo = { allFeatures = true },
					},
				},
			},
		},
	},

	autocmds = {
		{
			event = "LspAttach",
			callback = function(event)
				local map = keys.lsp(event)
				local client = vim.lsp.get_client_by_id(event.data.client_id)

				map({
					{
						"gd",
						function()
							require("telescope.builtin").lsp_definitions()
						end,
						desc = "[G]oto [D]efinition",
					},
					{
						"gr",
						function()
							require("telescope.builtin").lsp_references()
						end,
						desc = "[G]oto [R]eferences",
					},
					{
						"gI",
						function()
							require("telescope.builtin").lsp_implementations()
						end,
						desc = "[G]oto [I]mplementation",
					},
					{ "gD", vim.lsp.buf.declaration, desc = "[G]oto [D]eclaration" },
					{ "K", vim.lsp.buf.hover, desc = "Hover Documentation" },
					{ "<C-k>", vim.lsp.buf.signature_help, desc = "Signature Help", mode = "i" },
				})

				keys.register({
					{
						"<leader>D",
						function()
							require("telescope.builtin").lsp_type_definitions()
						end,
						desc = "Type [D]efinition",
					},
					{
						"<leader>ds",
						function()
							require("telescope.builtin").lsp_document_symbols()
						end,
						desc = "[D]ocument [S]ymbols",
					},
					{
						"<leader>ws",
						function()
							require("telescope.builtin").lsp_dynamic_workspace_symbols()
						end,
						desc = "[W]orkspace [S]ymbols",
					},
					{ "<leader>rn", vim.lsp.buf.rename, desc = "[R]e[n]ame" },
					{ "<leader>ca", vim.lsp.buf.code_action, desc = "[C]ode [A]ction" },
				})

				if client and client.server_capabilities.documentHighlightProvider then
					local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})
				end

				if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
					keys.register({
						{
							"<leader>th",
							function()
								vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
							end,
							desc = "[T]oggle Inlay [H]ints",
						},
					})
				end
			end,
		},
	},

	setup = function(opts)
		for name, icon in pairs({
			Error = "󰅚 ",
			Warn = "󰀪 ",
			Hint = "󰌶 ",
			Info = " ",
		}) do
			name = "DiagnosticSign" .. name
			vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
		end

		vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())

		require("mason-lspconfig").setup({
			ensure_installed = vim.tbl_keys(opts.servers),
			handlers = {
				function(server_name)
					local server = opts.servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
})
