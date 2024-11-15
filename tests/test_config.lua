local assert = require 'luassert'

local M = require 'ruscmd.config'
local defaults = {
    cabbrev = { 'bd', 'bn', 'q', 'qa', 'w', 'wq', 'wqa' },
}

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

it('should use default when empty', function()
    local cfg = M.new {}
    assert.same(defaults, cfg)
end)

it('should replace cabbrev when empty', function()
    local cfg = M.new { cabbrev = {} }
    assert.same({ cabbrev = {} }, cfg)
end)

it('should replace cabbrev when non-empty', function()
    local cfg = M.new { cabbrev = { 'one', 'two' } }
    assert.same({ cabbrev = { 'one', 'two' } }, cfg)
end)
