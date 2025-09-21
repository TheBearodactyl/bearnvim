local M = {}

--- @class KeySpec
--- @field [1] string Key combination
--- @field [2]? string|fun() Command or function
--- @field desc? string Description
--- @field mode? string|string[] Mode(s)
--- @field cond? boolean|fun(): boolean Condition
--- @field group? string Group name for which-key
--- @field buffer? number Buffer-local mapping
--- @field silent? boolean Silent mapping
--- @field noremap? boolean No-remap mapping
--- @field expr? boolean Expression mapping

local which_key_specs = {}
local initialized = false

--- Initialize the keys module
function M.init()
	if initialized then
		return
	end
	initialized = true

	vim.schedule(function()
		local success, wk = pcall(require, "which-key")
		if success and wk.add and #which_key_specs > 0 then
			local valid_specs = vim.tbl_filter(function(spec)
				return M._validate_keyspec(spec)
			end, which_key_specs)

			if #valid_specs > 0 then
				wk.add(valid_specs)
			end
		end
	end)
end

--- Validate a key specification
--- @param spec KeySpec
--- @return boolean
function M._validate_keyspec(spec)
	if type(spec) ~= "table" then
		return false
	end

	if type(spec[1]) ~= "string" or spec[1] == "" then
		vim.notify("Invalid key: must be a non-empty string", vim.log.levels.WARN)
		return false
	end

	return true
end

--- Register keys
--- @param keys KeySpec[]
function M.register(keys)
	if not keys or type(keys) ~= "table" then
		vim.notify("Keys must be a table", vim.log.levels.WARN)
		return
	end

	local valid_keys = {}

	for i, key in ipairs(keys) do
		if M._validate_keyspec(key) then
			if key.cond ~= nil then
				local should_include = false
				if type(key.cond) == "function" then
					local success, result = pcall(key.cond)
					should_include = success and result
				else
					should_include = not not key.cond
				end

				if not should_include then
					goto continue
				end
			end

			table.insert(valid_keys, key)
			table.insert(which_key_specs, key)

			local success, wk = pcall(require, "which-key")
			if success and wk.add then
				wk.add({ key })
			end
		else
			vim.notify(string.format("Invalid key specification at index %d", i), vim.log.levels.WARN)
		end

		::continue::
	end
end

--- Get all registered which-key specs
--- @return table
function M.get_which_key_specs()
	return vim.deepcopy(which_key_specs)
end

--- Create a key group
--- @param prefix string Key prefix
--- @param name string Group name
--- @param cond? boolean|fun(): boolean Condition
--- @return KeySpec
function M.group(prefix, name, cond)
	if type(prefix) ~= "string" or prefix == "" then
		error("Prefix must be a non-empty string", 2)
	end
	if type(name) ~= "string" or name == "" then
		error("Name must be a non-empty string", 2)
	end

	return { prefix, group = name, cond = cond }
end

--- Create buffer-local key mappings
--- @param keys KeySpec[]
--- @param buffer number Buffer number
function M.buffer(keys, buffer)
	if not keys or type(keys) ~= "table" then
		vim.notify("Keys must be a table", vim.log.levels.WARN)
		return
	end

	if type(buffer) ~= "number" or buffer < 0 then
		vim.notify("Buffer must be a valid buffer number", vim.log.levels.WARN)
		return
	end

	for i, key in ipairs(keys) do
		local success, err = pcall(function()
			if not M._validate_keyspec(key) then
				error("Invalid key specification")
			end

			local opts = {
				buffer = buffer,
				desc = key.desc,
				silent = key.silent ~= false,
				noremap = key.noremap ~= false,
				expr = key.expr or false,
			}

			local mode = key.mode or "n"
			local cmd = key[2] or key.callback or key.cmd

			if not cmd then
				error("Key must have a command or callback")
			end

			local modes = type(mode) == "string" and { mode } or mode

			for _, m in ipairs(modes) do
				vim.keymap.set(m, key[1], cmd, opts)
			end
		end)

		if not success then
			vim.notify(string.format("Error setting buffer key %d: %s", i, err), vim.log.levels.WARN)
		end
	end
end

--- Utility for LSP key mappings with validation
--- @param event table LSP attach event
--- @return fun(keys: KeySpec[])
function M.lsp(event)
	if not event or type(event.buf) ~= "number" then
		error("Invalid LSP event: must have a valid buffer number", 2)
	end

	return function(keys)
		M.buffer(keys, event.buf)
	end
end

--- Clear all registered specs
function M.clear()
	which_key_specs = {}
	initialized = false
end

M.init()

return M
