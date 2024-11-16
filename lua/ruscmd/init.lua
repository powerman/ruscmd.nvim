local Keymap = require 'ruscmd.keymap'

local M = {}

-- Setup mapping from Russian to English commands for Normal, Visual and Command-line modes.
---@param opts ruscmd.Options
M.setup = function(opts)
    local cfg = require('ruscmd.config').new(opts)

    -- Normal/Visual modes.
    if vim.o.langmap == '' then
        vim.opt.langmap = 'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ'
            .. ',фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz'
            .. ',ё`,Ё~,х[,Х{,ъ],Ъ},ж\\;,Ж:,э\',Э",б\\,,Б<,ю.,Ю>'
    end

    -- Command-line mode.
    local tmplCmd = "cabbrev <expr> %s getcmdtype()==':' && getcmdline()=='%s' ? '%s' : '%s'"
    for _, cmd in ipairs(cfg.cabbrev) do
        local cmdRu = Keymap.ru(cmd)
        if cmdRu ~= cmd then
            vim.cmd(tmplCmd:format(cmdRu, cmdRu, cmd, cmdRu))
        end
    end

    -- Global mappings.
    for mode, lhses in pairs(cfg.map) do
        for _, lhs in ipairs(lhses) do
            local lshRu = Keymap.lhsRu(lhs)
            if lshRu ~= lhs then
                vim.keymap.set(mode, lshRu, lhs, { remap = true })
            end
        end
    end
end

return M
