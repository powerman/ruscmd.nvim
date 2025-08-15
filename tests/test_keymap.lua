local assert = require 'luassert'

-- Clear module cache to avoid race conditions
package.loaded['ruscmd.keymap'] = nil

local M = require 'ruscmd.keymap'

describe('command', function()
    it('should handle empty string', function()
        assert.equals('', M.ru '')
    end)

    it('should not map digits', function()
        assert.equals('42', M.ru '42')
    end)

    it('should map letters', function()
        assert.equals('Дфян', M.ru 'Lazy')
    end)

    it('should map symbols', function()
        assert.equals('эБбэЮыщке', M.ru "'<,'>sort")
    end)
end)

describe('lhs', function()
    it('should handle empty string', function()
        assert.equals('', M.lhsRu '')
    end)

    it('should not map unbalanced <', function()
        assert.equals('<', M.lhsRu '<')
        assert.equals('Б<Б', M.lhsRu '<lt><<lt>')
    end)

    it('should not map <Plug>', function()
        assert.equals('<Plug>(some)', M.lhsRu '<Plug>(some)')
    end)
    it('should not map <SNR>', function()
        assert.equals('<SNR>42_some()', M.lhsRu '<SNR>42_some()')
    end)
    it('should map keycodes including case-insensitive <lt>', function()
        assert.equals('ф<Tab>иБёЯ', M.lhsRu 'a<Tab>b<Lt>`Z')
    end)
end)
