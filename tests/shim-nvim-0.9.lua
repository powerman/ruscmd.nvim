vim.uv = vim.uv or vim.loop

local function list_contains(t, value)
    for _, v in ipairs(t) do
        if v == value then
            return true
        end
    end
    return false
end
vim.list_contains = vim.list_contains or list_contains
