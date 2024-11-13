local assert = require 'luassert'

local child = require('mini.test').new_child_neovim()
teardown(child.stop)

local function child_lines()
    return child.api.nvim_buf_get_lines(0, 0, -1, true)
end

local lines = { 'Lorem', 'ipsum', 'dolor', 'sit', 'amet' }

before_each(function()
    child.restart { '--cmd', 'set rtp+=.' }
    child.api.nvim_buf_set_lines(0, 0, -1, true, lines)
end)

describe('langmap', function()
    it('without plugin `овв` should do nothing', function()
        child.type_keys 'овв'
        assert.same(lines, child_lines())
    end)

    it('`овв` should work as `jdd`', function()
        child.lua [[ require('ruscmd').setup {} ]]
        child.type_keys 'овв'
        assert.same({ 'Lorem', 'dolor', 'sit', 'amet' }, child_lines())
    end)
end)

describe('cabbrev', function()
    it('without plugin `Жив!<CR>Жй<CR>` should do nothing', function()
        child.type_keys 'Жив!<CR>'
        assert.same(lines, child_lines())
        assert.no_error(function()
            child.type_keys 'Жй<CR>'
        end)
    end)

    it('`Жив!<CR>Жй<CR>` should work as `:bd!<CR>:q<CR>`', function()
        child.lua [[ require('ruscmd').setup {} ]]
        child.type_keys 'Жив!<CR>'
        assert.same({ '' }, child_lines())
        assert.error_matches(function()
            child.type_keys 'Жй<CR>'
        end, 'Invalid channel')
    end)

    it('should add new command', function()
        child.lua [[ require('ruscmd').setup {cabbrev={ ['рудз']='help' }} ]]
        child.type_keys 'Жрудз<CR>'
        assert.matches('^[*]help[.]txt[*]', child_lines()[1])
    end)

    it('should remove default command', function()
        child.lua [[ require('ruscmd').setup {cabbrev={ ['й']='й' }} ]]
        child.type_keys 'Жив!<CR>'
        assert.same({ '' }, child_lines())
        assert.error_match(function()
            child.type_keys 'Жй<CR>'
        end, 'E492:')
    end)
end)