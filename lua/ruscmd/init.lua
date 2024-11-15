local Keymap = require 'ruscmd.keymap'

local M = {}

-- Setup mapping from Russian to English commands for Normal, Visual and Command-line modes.
---@param opts ruscmd.Options
M.setup = function(opts)
    local cfg = require('ruscmd.config').new(opts)

    -- Normal/Visual modes.
    vim.opt.langmap = 'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ'
        .. ',фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz'
        .. ',ё`,Ё~,х[,Х{,ъ],Ъ},ж\\;,Ж:,э\',Э",б\\,,Б<,ю.,Ю>'

    -- Command-line mode.
    for _, rhs in ipairs(cfg.cabbrev) do
        local lhs = Keymap.ru(rhs)
        local tmpl = "cabbrev <expr> %s getcmdtype()==':' && getcmdline()=='%s' ? '%s' : '%s'"
        vim.cmd(tmpl:format(lhs, lhs, rhs, lhs))
    end

    -- Default-mappings.
    vim.keymap.set('n', 'Н', 'Y', { remap = true })
    vim.keymap.set('x', 'Й', 'Q', { remap = true })
    for _, mode in ipairs { 'o', 'x', 'n' } do
        vim.keymap.set(mode, 'пс', 'gc', { remap = true })
    end
    vim.keymap.set('n', 'псс', 'gcc', { remap = true })
    vim.keymap.set('n', 'ъв', ']d', { remap = true })
    vim.keymap.set('n', 'хв', '[d', { remap = true })
    vim.keymap.set('n', '<C-W>в', '<C-W>d', { remap = true })
    vim.keymap.set('n', 'Л', 'K', { remap = true })
end

return M
