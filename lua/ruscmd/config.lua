local Validate = require 'ruscmd.validate'

local M = {}

---@class ruscmd.Options
---@field cabbrev? table<string> Command-line mode commands to be abbreviated in Russian.
local defaults = {
    cabbrev = { 'bd', 'bn', 'q', 'qa', 'w', 'wq', 'wqa' },
}

---@class Config: ruscmd.Options

---@param opts ruscmd.Options
---@return Config
M.new = function(opts)
    opts = opts or {}

    vim.validate {
        opts = { opts, 'table' },
        ['opts.cabbrev'] = {
            opts.cabbrev,
            Validate.list('opts.cabbrev', 's', true),
            'table<string>?',
        },
    }

    return vim.tbl_deep_extend('force', {}, defaults, opts)
end

return M
