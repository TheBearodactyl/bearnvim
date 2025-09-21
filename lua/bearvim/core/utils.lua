local M = {}

--- @return boolean
M.is_rust = function()
	return vim.bo.filetype == "rust"
end

return M
