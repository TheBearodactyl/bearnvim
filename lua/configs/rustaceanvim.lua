local config = require("core.config")
local keys = require("core.keys")

return config.create({
	options = {
		tools = {
			hover_actions = {
				auto_focus = false,
				border = "rounded",
				width = 60,
				height = 30,
			},
			code_actions = {
				ui_select_fallback = true,
			},
			float_win_config = {
				border = "rounded",
				auto_focus = false,
			},
			crate_graph = {
				backend = "x11",
				output = nil,
				full = true,
				enabled_graphviz_backends = {
					"bmp",
					"cgimage",
					"canon",
					"dot",
					"gv",
					"xdot",
					"xdot1.2",
					"xdot1.4",
					"eps",
					"exr",
					"fig",
					"gd",
					"gd2",
					"gif",
					"gtk",
					"ico",
					"cmap",
					"ismap",
					"imap",
					"cmapx",
					"imap_np",
					"cmapx_np",
					"jpg",
					"jpeg",
					"jpe",
					"jp2",
					"json",
					"json0",
					"dot_json",
					"xdot_json",
					"pdf",
					"pic",
					"pct",
					"pict",
					"plain",
					"plain-ext",
					"png",
					"pov",
					"ps",
					"ps2",
					"psd",
					"sgi",
					"svg",
					"svgz",
					"tga",
					"tiff",
					"tif",
					"tk",
					"vml",
					"vmlz",
					"wbmp",
					"webp",
					"xlib",
					"x11",
				},
			},
		},
		server = {
			on_attach = function(client, bufnr)
				local map = keys.lsp({ buf = bufnr })

				map({
					{
						"K",
						function()
							vim.cmd.RustLsp({ "hover", "actions" })
						end,
						desc = "Rust Hover Actions",
					},
					{
						"<leader>a",
						function()
							vim.cmd.RustLsp("codeAction")
						end,
						desc = "Rust Code Action",
					},
					{
						"<leader>dr",
						function()
							vim.cmd.RustLsp("debuggables")
						end,
						desc = "[D]ebug [R]ust",
					},
					{
						"<leader>rr",
						function()
							vim.cmd.RustLsp("runnables")
						end,
						desc = "[R]ust [R]unnables",
					},
					{
						"<leader>rt",
						function()
							vim.cmd.RustLsp("testables")
						end,
						desc = "[R]ust [T]estables",
					},
					{
						"<leader>rm",
						function()
							vim.cmd.RustLsp("expandMacro")
						end,
						desc = "[R]ust Expand [M]acro",
					},
					{
						"<leader>rc",
						function()
							vim.cmd.RustLsp("openCargo")
						end,
						desc = "[R]ust Open [C]argo.toml",
					},
					{
						"<leader>rp",
						function()
							vim.cmd.RustLsp("parentModule")
						end,
						desc = "[R]ust [P]arent Module",
					},
					{
						"<leader>rd",
						function()
							vim.cmd.RustLsp("openDocs")
						end,
						desc = "[R]ust Open [D]ocs",
					},
					{
						"<leader>re",
						function()
							vim.cmd.RustLsp("explainError")
						end,
						desc = "[R]ust [E]xplain Error",
					},
					{
						"<leader>rR",
						function()
							vim.cmd.RustLsp("reload")
						end,
						desc = "[R]ust [R]eload Workspace",
					},
				})

				keys.register({
					keys.group("<leader>r", "[R]ust"),
					{
						"<leader>rr",
						function()
							vim.cmd.RustLsp("runnables")
						end,
						desc = "[R]ust [R]unnables",
					},
					{
						"<leader>rt",
						function()
							vim.cmd.RustLsp("testables")
						end,
						desc = "[R]ust [T]estables",
					},
					{
						"<leader>rd",
						function()
							vim.cmd.RustLsp("debuggables")
						end,
						desc = "[R]ust [D]ebuggables",
					},
					{
						"<leader>rm",
						function()
							vim.cmd.RustLsp("expandMacro")
						end,
						desc = "[R]ust Expand [M]acro",
					},
					{
						"<leader>rc",
						function()
							vim.cmd.RustLsp("openCargo")
						end,
						desc = "[R]ust Open [C]argo.toml",
					},
					{
						"<leader>rp",
						function()
							vim.cmd.RustLsp("parentModule")
						end,
						desc = "[R]ust [P]arent Module",
					},
					{
						"<leader>re",
						function()
							vim.cmd.RustLsp("explainError")
						end,
						desc = "[R]ust [E]xplain Error",
					},
					{
						"<leader>rg",
						function()
							vim.cmd.RustLsp("crateGraph")
						end,
						desc = "[R]ust Crate [G]raph",
					},
					{
						"<leader>rR",
						function()
							vim.cmd.RustLsp("reload")
						end,
						desc = "[R]ust [R]eload Workspace",
					},
				})
			end,
			default_settings = {
				["rust-analyzer"] = {
					cargo = {
						allFeatures = true,
						loadOutDirsFromCheck = true,
						buildScripts = {
							enable = true,
						},
					},
					checkOnSave = {
						allFeatures = true,
						command = "clippy",
						extraArgs = { "--no-deps" },
					},
					procMacro = {
						enable = true,
						ignored = {
							["async-trait"] = { "async_trait" },
							["napi-derive"] = { "napi" },
							["async-recursion"] = { "async_recursion" },
						},
					},
					inlayHints = {
						bindingModeHints = {
							enable = false,
						},
						chainingHints = {
							enable = true,
						},
						closingBraceHints = {
							enable = true,
							minLines = 25,
						},
						closureReturnTypeHints = {
							enable = "never",
						},
						lifetimeElisionHints = {
							enable = "never",
							useParameterNames = false,
						},
						maxLength = 25,
						parameterHints = {
							enable = true,
						},
						reborrowHints = {
							enable = "never",
						},
						renderColons = true,
						typeHints = {
							enable = true,
							hideClosureInitialization = false,
							hideNamedConstructor = false,
						},
					},
				},
			},
		},
		dap = {
			adapter = {
				type = "executable",
				command = "lldb-vscode",
				name = "rt_lldb",
			},
		},
	},

	setup = function(opts)
		vim.g.rustaceanvim = opts
	end,
})
