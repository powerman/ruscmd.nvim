local M = {}

--- Compatibility wrapper for vim.validate that works with both old and new API
---@param name string
---@param value any
---@param validator string|function|string[]
---@param optional boolean?
---@param message string?
M.validate = function(name, value, validator, optional, message)
    if
        vim.version and vim.version().major >= 1
        or (vim.version().major == 0 and vim.version().minor >= 11)
    then
        -- New form for 0.11+
        vim.validate(name, value, validator, optional, message)
    else
        -- Old form for < 0.11
        local spec = {}
        if optional then
            if message then
                spec[name] = { value, validator, true, message }
            else
                spec[name] = { value, validator, true }
            end
        else
            if message then
                spec[name] = { value, validator, message }
            else
                spec[name] = { value, validator }
            end
        end
        vim.validate(spec)
    end
end

return M
