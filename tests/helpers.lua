local M = {}

--- Clear all loaded modules with given prefix to avoid race conditions in tests
---@param prefix string Module prefix (e.g., 'ruscmd')
M.clear_modules = function(prefix)
    local prefix_dot = prefix .. '.'
    for module_name, _ in pairs(package.loaded) do
        if module_name == prefix or module_name:sub(1, #prefix_dot) == prefix_dot then
            package.loaded[module_name] = nil
        end
    end
end

return M
