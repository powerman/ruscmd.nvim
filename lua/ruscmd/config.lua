local V = require 'ruscmd.validate'
local compat = require 'ruscmd.compat'

local M = {}

---@class ruscmd.OptionMap
---@field n? table<string>
---@field v? table<string>
---@field x? table<string>
---@field s? table<string>
---@field o? table<string>
---@field i? table<string>
---@field l? table<string>
---@field c? table<string>
---@field t? table<string>

---@class ruscmd.Config
---@field cabbrev? table<string> Command-line mode commands to be abbreviated in Russian.
---@field map? ruscmd.OptionMap Global mappings to be remapped from Russian keys.
local defaults = {
    cabbrev = { 'bd', 'bn', 'q', 'qa', 'w', 'wq', 'wqa' },
    map = { -- :help default-mappings
        n = { 'Y', 'gc', 'gcc', ']d', '[d', '<C-W>d', 'K' },
        x = { 'Q', 'gc' },
        o = { 'gc' },
    },
}

---@class ruscmd.Options: ruscmd.Config
---@field replace? boolean If true then user-provided keys will replace defaults for these keys.

---@param opts ruscmd.Options
---@return ruscmd.Config
M.new = function(opts)
    compat.validate('opts', opts, 'table', true)
    opts = opts or {}
    compat.validate('opts.replace', opts.replace, 'boolean', true)
    compat.validate(
        'opts.cabbrev',
        opts.cabbrev,
        V.list('opts.cabbrev', 'string', true),
        true,
        'table<string>?'
    )
    compat.validate('opts.map', opts.map, 'table', true)
    opts.map = opts.map or {}

    local map_modes = { 'n', 'v', 'x', 's', 'o', 'i', 'l', 'c', 't' }
    for _, mode in ipairs(map_modes) do
        compat.validate(
            'opts.map.' .. mode,
            opts.map[mode],
            V.list('opts.map.' .. mode, 'string', true),
            true,
            'table<string>?'
        )
    end

    local cfg = vim.tbl_deep_extend('force', {}, defaults, opts)
    cfg.replace = nil

    if not opts.replace then
        if opts.cabbrev ~= nil then
            cfg.cabbrev = vim.deepcopy(defaults.cabbrev)
            for _, v in ipairs(opts.cabbrev) do
                table.insert(cfg.cabbrev, v)
            end
        end
        for k in pairs(defaults.map) do
            if opts.map and opts.map[k] then
                cfg.map[k] = vim.deepcopy(defaults.map[k])
                for _, v in ipairs(opts.map[k]) do
                    table.insert(cfg.map[k], v)
                end
            end
        end
    end

    return cfg
end

return M
