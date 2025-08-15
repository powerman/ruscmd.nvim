local assert = require 'luassert'

-- Clear module cache to avoid race conditions
require('tests.helpers').clear_modules 'ruscmd'

local M = require 'ruscmd.config'
local defaults = {
    cabbrev = { 'bd', 'bn', 'q', 'qa', 'w', 'wq', 'wqa' },
    map = { -- :help default-mappings
        n = { 'Y', 'gc', 'gcc', ']d', '[d', '<C-W>d', 'K' },
        x = { 'Q', 'gc' },
        o = { 'gc' },
    },
}

describe('wrong opts type', function()
    it('should fail on invalid opts type', function()
        assert.error_matches(function()
            M.new 'bad'
        end, 'opts: expected table, got string')
    end)

    it('should use default without opts', function()
        local cfg = M.new()
        assert.same(defaults, cfg)
    end)

    it('should use default when nil', function()
        local cfg = M.new(nil)
        assert.same(defaults, cfg)
    end)
end)

describe('empty value', function()
    describe('without replace', function()
        it('should use default when empty', function()
            local cfg = M.new {}
            assert.same(defaults, cfg)
        end)

        it('should use default when keys are empty', function()
            local cfg = M.new { cabbrev = {}, map = {} }
            assert.same(defaults, cfg)
        end)

        it('should use default when map keys are empty', function()
            local cfg = M.new { map = { n = {} } }
            assert.same(defaults, cfg)
        end)
    end)

    describe('with replace', function()
        it('should replace cabbrev when key is empty', function()
            local cfg = M.new { replace = true, cabbrev = {} }
            assert.same({ cabbrev = {}, map = defaults.map }, cfg)
        end)

        it('should not replace map when key is empty', function()
            local cfg = M.new { replace = true, map = {} }
            assert.same(defaults, cfg)
        end)

        it('should replace map.mode when key is empty', function()
            local cfg = M.new { replace = true, map = { n = {} } }
            assert.same({
                cabbrev = defaults.cabbrev,
                map = { n = {}, x = defaults.map.x, o = defaults.map.o },
            }, cfg)
        end)
    end)
end)

describe('non-empty value', function()
    describe('without replace', function()
        it('should append cabbrev', function()
            local cfg = M.new { cabbrev = { 'one', 'two' } }
            local want = { 'bd', 'bn', 'q', 'qa', 'w', 'wq', 'wqa', 'one', 'two' }
            assert.same({ cabbrev = want, map = defaults.map }, cfg)
        end)

        it('should append map.mode', function()
            local cfg = M.new { map = { x = { 'sa' } } }
            assert.same({
                cabbrev = defaults.cabbrev,
                map = { n = defaults.map.n, x = { 'Q', 'gc', 'sa' }, o = defaults.map.o },
            }, cfg)
        end)

        it('should add new map.mode', function()
            local cfg = M.new { replace = true, map = { v = { 'Y' } } }
            assert.same({
                cabbrev = defaults.cabbrev,
                map = {
                    n = defaults.map.n,
                    x = defaults.map.x,
                    o = defaults.map.o,
                    v = { 'Y' },
                },
            }, cfg)
        end)
    end)

    describe('with replace', function()
        it('should replace cabbrev', function()
            local cfg = M.new { replace = true, cabbrev = { 'one', 'two' } }
            assert.same({ cabbrev = { 'one', 'two' }, map = defaults.map }, cfg)
        end)

        it('should replace map.mode', function()
            local cfg = M.new { replace = true, map = { x = { 'sa' } } }
            assert.same({
                cabbrev = defaults.cabbrev,
                map = { n = defaults.map.n, x = { 'sa' }, o = defaults.map.o },
            }, cfg)
        end)

        it('should add new map.mode', function()
            local cfg = M.new { replace = true, map = { v = { 'Y' } } }
            assert.same({
                cabbrev = defaults.cabbrev,
                map = {
                    n = defaults.map.n,
                    x = defaults.map.x,
                    o = defaults.map.o,
                    v = { 'Y' },
                },
            }, cfg)
        end)
    end)
end)
