local assert = require 'luassert'

local M = require 'ruscmd.validate'

describe('list', function()
    it('should accept nil when optional', function()
        assert.no_error(function()
            vim.validate { v = { nil, M.list('v', 's', true), 'table<string>?' } }
        end)
    end)

    it('should reject nil when required', function()
        assert.error_matches(function()
            vim.validate { v = { nil, M.list('v', 's'), 'table<string>' } }
        end, 'v: expected table<string>, got nil')
        assert.error_matches(function()
            vim.validate { v = { nil, M.list('v', 's', false), 'table<string>' } }
        end, 'v: expected table<string>, got nil')
    end)

    it('should reject non-table', function()
        assert.error_matches(function()
            vim.validate { v = { 1, M.list('v', 'n'), 'table<number>' } }
        end, 'v: expected table<number>, got 1')
    end)

    it('should reject non-list table', function()
        assert.error_matches(function()
            vim.validate { v = { { 1, 2, k = 3 }, M.list('v', 'n'), 'table<number>' } }
        end, 'v: expected table<number>, got .* Info: table is not a list')
    end)
end)

describe('list values', function()
    it('should accept empty list', function()
        assert.no_error(function()
            vim.validate { v = { {}, M.list('v', 'n'), 'table<number>' } }
        end)
    end)
    it('should accept all values with given type', function()
        assert.no_error(function()
            vim.validate { v = { { 1, 2 }, M.list('v', 'n'), 'table<number>' } }
        end)
    end)
    it('should accept all values with given types', function()
        assert.no_error(function()
            vim.validate {
                v = { { 1, 'two' }, M.list('v', { 'n', 's' }), 'table<number|string>' },
            }
        end)
    end)
    it('should reject value with unexpected type', function()
        assert.error_matches(function()
            vim.validate {
                v = { { 1, true, 'three' }, M.list('v', { 'n', 's' }), 'table<number|string>' },
            }
        end, 'v%[2]: expected number|string, got boolean')
    end)
end)
