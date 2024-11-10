vim.env.XDG_CONFIG_HOME = vim.uv.cwd() .. '/tests/.config'
vim.env.XDG_CACHE_HOME = vim.uv.cwd() .. '/.buildcache/tests/cache'
vim.env.XDG_DATA_HOME = vim.uv.cwd() .. '/.buildcache/tests/data'
vim.env.XDG_STATE_HOME = vim.uv.cwd() .. '/.buildcache/tests/state'

vim.opt.rtp:prepend '.'

---@type LazyConfig
local config = {
    spec = {
        { dir = vim.uv.cwd() },
        { 'folke/lazy.nvim', version = '*' },
        { 'echasnovski/mini.test', version = '*' },
        { 'lunarmodules/luassert', version = '*' },
    },
}

require('tests.lazy_bootstrap').setup()

--  Use:
--      --lazy-restore  after repo clone (e.g. on CI) or a `git pull` which updated lockfile
--      --lazy-update   to manually update all plugins and lockfile
--      none of them    to run tests
--  These options can be combined with option used to run tests (e.g. --minitest).
if vim.list_contains(arg or {}, '--lazy-restore') then
    require('lazy').update = require('lazy').restore -- Restores all but lazy. https://github.com/folke/lazy.nvim/issues/1787#issuecomment-2466916283
elseif not vim.list_contains(arg or {}, '--lazy-update') then
    require('lazy').update = require('lazy').install -- Avoid ~2 sec delay before running tests.
end
require('lazy.minit').setup(config) -- Calls lazy.update().
