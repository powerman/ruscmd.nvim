--[==[

Usage: nvim -l tests/run.lua [--lazy-restore|--lazy-update] [--minitest|--busted [--output=json]]

  --lazy-restore  Restore all plugins accordingly to current lockfile (after `git clone|pull`).
  --lazy-update   Update all plugins and lockfile.
  --minitest      Run tests in tests/**/test_*.lua.
  --busted        Run tests in tests/**/*_spec.lua.

--]==]

vim.env.XDG_CONFIG_HOME = vim.uv.cwd() .. '/tests/.config'
vim.env.XDG_CACHE_HOME = vim.uv.cwd() .. '/.buildcache/tests/cache'
vim.env.XDG_DATA_HOME = vim.uv.cwd() .. '/.buildcache/tests/data'
vim.env.XDG_STATE_HOME = vim.uv.cwd() .. '/.buildcache/tests/state'

---@type LazyConfig
local config = {
    defaults = { version = '*' },
    rocks = { hererocks = true },
    spec = {
        'lunarmodules/luassert',
        {
            'echasnovski/mini.test',
            opts = {
                collect = {
                    find_files = function() -- Restore default overwritten by lazy.minit.
                        return vim.fn.globpath('tests', '**/test_*.lua', true, true)
                    end,
                },
            },
        },
    },
}

require('tests.lazy_bootstrap').setup()

if vim.list_contains(arg or {}, '--lazy-restore') then
    require('lazy').update = require('lazy').restore -- Restores all but lazy. https://github.com/folke/lazy.nvim/issues/1787#issuecomment-2466916283
elseif not vim.list_contains(arg or {}, '--lazy-update') then
    require('lazy').update = require('lazy').install -- Avoid ~2 sec delay before running tests.
end
require('lazy.minit').setup(config) -- Calls lazy.update() and then may run tests.
