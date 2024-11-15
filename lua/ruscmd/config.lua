local V = require 'ruscmd.validate'

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

---@class Config
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

---@class ruscmd.Options: Config
---@field replace? boolean If true then user-provided keys will replace defaults for these keys.

---@param opts ruscmd.Options
---@return Config
M.new = function(opts)
    vim.validate { opts = { opts, 'table', true } }
    opts = opts or {}
    vim.validate {
        ['opts.replace'] = { opts.replace, 'b', true },
        ['opts.cabbrev'] = {
            opts.cabbrev,
            V.list('opts.cabbrev', 's', true),
            'table<string>?',
        },
        ['opts.map'] = { opts.map, 'table', true },
    }
    opts.map = opts.map or {}
    vim.validate {
        ['opts.map.n'] = { opts.map.n, V.list('opts.map.n', 's', true), 'table<string>?' },
        ['opts.map.v'] = { opts.map.v, V.list('opts.map.v', 's', true), 'table<string>?' },
        ['opts.map.x'] = { opts.map.x, V.list('opts.map.x', 's', true), 'table<string>?' },
        ['opts.map.s'] = { opts.map.s, V.list('opts.map.s', 's', true), 'table<string>?' },
        ['opts.map.o'] = { opts.map.o, V.list('opts.map.o', 's', true), 'table<string>?' },
        ['opts.map.i'] = { opts.map.i, V.list('opts.map.i', 's', true), 'table<string>?' },
        ['opts.map.l'] = { opts.map.l, V.list('opts.map.l', 's', true), 'table<string>?' },
        ['opts.map.c'] = { opts.map.c, V.list('opts.map.c', 's', true), 'table<string>?' },
        ['opts.map.t'] = { opts.map.t, V.list('opts.map.t', 's', true), 'table<string>?' },
    }

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
