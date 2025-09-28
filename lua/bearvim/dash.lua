local if_nil = vim.F.if_nil
local uv = vim.loop
local json = vim.json

local state_file = vim.fn.stdpath("data") .. "/image_state.json"

local function load_state()
	local fd = uv.fs_open(state_file, "r", 438)
	if not fd then return nil end
	local stat = uv.fs_fstat(fd)
	local data = uv.fs_read(fd, stat.size, 0)
	uv.fs_close(fd)
	if not data or data == "" then return nil end
	return json.decode(data)
end

local function save_state(state)
	local fd = uv.fs_open(state_file, "w", 438)
	if not fd then return end
	uv.fs_write(fd, json.encode(state), 0)
	uv.fs_close(fd)
end

local function random_image()
	local ok, luv = pcall(require, "luv")
	math.randomseed(ok and luv.hrtime() or os.time())

	local image_modules = {
		"bearvim.images.check",
		"bearvim.images.dawgs",
		"bearvim.images.igloo",
		"bearvim.images.lemon",
		"bearvim.images.mob",
		"bearvim.images.mobfarm",
		"bearvim.images.morris",
		"bearvim.images.nichto",
		"bearvim.images.rat",
		"bearvim.images.rat2",
		"bearvim.images.reigen",
		"bearvim.images.truth-nuke",
	}

	local state = load_state() or { remaining = vim.deepcopy(image_modules) }

	if #state.remaining == 0 then state.remaining = vim.deepcopy(image_modules) end

	local idx = math.random(#state.remaining)
	local choice = state.remaining[idx]

	table.remove(state.remaining, idx)

	save_state(state)

	return require(choice)
end

local default_terminal = {
	type = "terminal",
	command = nil,
	width = 69,
	height = 8,
	opts = {
		redraw = true,
		window_config = {},
	},
}

local default_header = {
	type = "text",
	val = random_image(),
	opts = {
		position = "center",
		hl = "Type",
	},
}

local footer = {
	type = "text",
	val = "",
	opts = {
		position = "center",
		hl = "Number",
	},
}

local leader = "SPC"

--- @param sc string
--- @param txt string
--- @param keybind string? optional
--- @param keybind_opts table? optional
local function button(sc, txt, keybind, keybind_opts)
	local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

	local opts = {
		position = "center",
		shortcut = sc,
		cursor = 3,
		width = 50,
		align_shortcut = "right",
		hl_shortcut = "Keyword",
	}
	if keybind then
		keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
		opts.keymap = { "n", sc_, keybind, keybind_opts }
	end

	local function on_press()
		local key = vim.api.nvim_replace_termcodes(keybind or sc_ .. "<Ignore>", true, false, true)
		vim.api.nvim_feedkeys(key, "t", false)
	end

	return {
		type = "button",
		val = txt,
		on_press = on_press,
		opts = opts,
	}
end

local buttons = {
	type = "group",
	val = {
		button("e", "  New file", "<cmd>ene <CR>"),
		button("SPC f f", "󰈞  Find file"),
		button("SPC f h", "󰊄  Recently opened files"),
		button("SPC f r", "  Frecency/MRU"),
		button("SPC f g", "󰈬  Find word"),
		button("SPC f m", "  Jump to bookmarks"),
		button("SPC s l", "  Open last session"),
	},
	opts = {
		spacing = 1,
	},
}

local section = {
	terminal = default_terminal,
	header = default_header,
	buttons = buttons,
	footer = footer,
}

local config = {
	layout = {
		{ type = "padding", val = 2 },
		section.header,
		{ type = "padding", val = 2 },
		section.buttons,
		section.footer,
	},
	opts = {
		margin = 5,
	},
}

return {
	button = button,
	section = section,
	config = config,
	leader = leader,
	opts = config,
}
