local M = {}

---@class Config
---@field cabbrev? table<string,string> Abbreviations for Command-line mode
M.defaultConfig = {
    cabbrev = {
        ['ив'] = 'bd',
        ['ит'] = 'bn',
        ['й'] = 'q',
        ['йф'] = 'qa',
        ['ц'] = 'w',
        ['цй'] = 'wq',
        ['цйф'] = 'wqa',
    },
}

---@type Config
M.cfg = {}

-- Setup mapping from Russian to English commands for Normal, Visual and Command-line modes.
---@param config Config
M.setup = function(config)
    M.cfg = vim.tbl_deep_extend('force', {}, M.defaultConfig, config or {})

    -- Normal/Visual modes.
    vim.opt.langmap = 'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ'
        .. ',фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz'
        .. ',ё`,Ё~,х[,Х{,ъ],Ъ},ж\\;,Ж:,э\',Э",б\\,,Б<,ю.,Ю>'

    -- Command-line mode.
    for lhs, rhs in pairs(M.cfg.cabbrev) do
        local tmpl = "cabbrev <expr> %s getcmdtype()==':' && getcmdline()=='%s' ? '%s' : '%s'"
        vim.cmd(string.format(tmpl, lhs, lhs, rhs, lhs))
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
