local compat = require 'ruscmd.compat'

local M = {}

---@alias TypeNameEnum "table"|"t"|"string"|"s"|"number"|"n"|"boolean"|"b"|"function"|"f"|"nil"|"thread"|"userdata"
---@alias TypeName TypeNameEnum|TypeNameEnum[]

--- Validate list values.
---
---@usage lua<
---     vim.validate('arg1', value, Validate.list('arg1', 'string', true), true, 'table<string>?')
---     vim.validate('arg1', value, Validate.list('arg1', 'string|number'), false, 'table<string|number>')
--->
---@param arg_name string
---@param val_type TypeName
---@param is_optional boolean?
---@return fun(table): (boolean, string?)
M.list = function(arg_name, val_type, is_optional)
    return function(t)
        if t == nil then
            return is_optional and is_optional or false
        end
        if type(t) ~= 'table' then
            return false
        end
        for k, v in pairs(t) do
            if type(k) ~= 'number' then
                return false, 'table is not a list'
            end
            compat.validate(string.format('%s[%s]', arg_name, k), v, val_type)
        end
        return true
    end
end

return M
