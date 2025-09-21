local M = {}

---@class ConfigModule
---@field options? table Default options
---@field setup? fun(opts?: table) Setup function
---@field keys? table Key mappings
---@field commands? table User commands
---@field autocmds? table Autocommands

---Create a configuration module
---@param config ConfigModule
---@return ConfigModule
function M.create(config)
	local module = {}

	if config.options then
		module.options = config.options
	end

	if config.setup then
		module.setup = function(opts)
			opts = vim.tbl_deep_extend("force", config.options or {}, opts or {})

			if config.autocmds then
				local augroup = vim.api.nvim_create_augroup("config_" .. (config.name or "default"), { clear = true })
				for _, autocmd in ipairs(config.autocmds) do
					local autocmd_opts = vim.tbl_deep_extend("force", {}, autocmd)
					autocmd_opts.group = autocmd_opts.group or augroup
					local event = autocmd_opts.event
					autocmd_opts.event = nil
					vim.api.nvim_create_autocmd(event, autocmd_opts)
				end
			end

			if config.commands then
				for name, command in pairs(config.commands) do
					local callback = command.callback or command[1]
					local opts_cmd = command.opts or {}
					vim.api.nvim_create_user_command(name, callback, opts_cmd)
				end
			end

			return config.setup(opts)
		end
	else
		module.setup = function() end
	end

	if config.keys then
		module.keys = config.keys
	end

	return module
end

---Helper for conditional configuration
---@param condition boolean|fun(): boolean
---@param config table
---@return table|nil
function M.when(condition, config)
	if type(condition) == "function" then
		if condition() then
			return config
		end
	elseif condition then
		return config
	end
	return nil
end

---Helper for filetype-specific configuration
---@param filetypes string|string[]
---@param config table
---@return table
function M.filetype(filetypes, config)
	if type(filetypes) == "string" then
		filetypes = { filetypes }
	end

	config.ft = filetypes
	return config
end

return M
