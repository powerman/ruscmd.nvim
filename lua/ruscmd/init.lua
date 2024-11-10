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
end

return M
