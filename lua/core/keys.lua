local M = {}

---@class KeySpec
---@field [1] string Key combination
---@field [2]? string|fun() Command or function
---@field desc? string Description
---@field mode? string|string[] Mode(s)
---@field cond? boolean|fun(): boolean Condition
---@field group? string Group name for which-key

local which_key_specs = {}

---Register keys with which-key integration
---@param keys KeySpec[]
function M.register(keys)
  for _, key in ipairs(keys) do
    table.insert(which_key_specs, key)
  end
end

---Get all registered which-key specs
---@return table
function M.get_which_key_specs()
  return which_key_specs
end

---Create a key group
---@param prefix string Key prefix
---@param name string Group name
---@param cond? boolean|fun(): boolean Condition
---@return KeySpec
function M.group(prefix, name, cond)
  return { prefix, group = name, cond = cond }
end

---Create a buffer-local key mapping
---@param keys KeySpec[]
---@param buffer number Buffer number
function M.buffer(keys, buffer)
  for _, key in ipairs(keys) do
    local opts = {
      buffer = buffer,
      desc = key.desc,
      silent = key.silent ~= false,
    }
    
    local mode = key.mode or "n"
    local cmd = key[2] or key.callback or key.cmd
    
    if type(mode) == "string" then
      vim.keymap.set(mode, key[1], cmd, opts)
    else
      for _, m in ipairs(mode) do
        vim.keymap.set(m, key[1], cmd, opts)
      end
    end
  end
end

---Utility for LSP key mappings
---@param event table LSP attach event
---@return fun(keys: KeySpec[])
function M.lsp(event)
  return function(keys)
    M.buffer(keys, event.buf)
  end
end

return M
