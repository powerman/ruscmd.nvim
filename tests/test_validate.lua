local assert = require 'luassert'

-- Clear module cache to avoid race conditions
require('tests.helpers').clear_modules 'ruscmd'

local M = require 'ruscmd.validate'
local compat = require 'ruscmd.compat'

describe('list', function()
    it('should accept nil when optional', function()
        assert.no_error(function()
            compat.validate('v', nil, M.list('v', 'string', true), true, 'table<string>?')
        end)
    end)

    it('should reject nil when required', function()
        assert.error_matches(function()
            compat.validate('v', nil, M.list('v', 'string'), false, 'table<string>')
        end, 'v: expected table<string>, got nil')
        assert.error_matches(function()
            compat.validate('v', nil, M.list('v', 'string', false), false, 'table<string>')
        end, 'v: expected table<string>, got nil')
    end)

    it('should reject non-table', function()
        assert.error_matches(function()
            compat.validate('v', 1, M.list('v', 'number'), false, 'table<number>')
        end, 'v: expected table<number>, got 1')
    end)

    it('should reject non-list table', function()
        assert.error_matches(function()
            compat.validate('v', { 1, 2, k = 3 }, M.list('v', 'number'), false, 'table<number>')
        end, 'v: expected table<number>, got .* Info: table is not a list')
    end)
end)

describe('list values', function()
    it('should accept empty list', function()
        assert.no_error(function()
            compat.validate('v', {}, M.list('v', 'number'), false, 'table<number>')
        end)
    end)
    it('should accept all values with given type', function()
        assert.no_error(function()
            compat.validate('v', { 1, 2 }, M.list('v', 'number'), false, 'table<number>')
        end)
    end)
    it('should accept all values with given types', function()
        assert.no_error(function()
            compat.validate(
                'v',
                { 1, 'two' },
                M.list('v', { 'number', 'string' }),
                false,
                'table<number|string>'
            )
        end)
    end)
    it('should reject value with unexpected type', function()
        assert.error_matches(function()
            compat.validate(
                'v',
                { 1, true, 'three' },
                M.list('v', { 'number', 'string' }),
                false,
                'table<number|string>'
            )
        end, 'v%[2]: expected number|string, got boolean')
    end)
end)
