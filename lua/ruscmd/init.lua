local M = {}

local ruChar = {
    q = 'й',
    w = 'ц',
    e = 'у',
    r = 'к',
    t = 'е',
    y = 'н',
    u = 'г',
    i = 'ш',
    o = 'щ',
    p = 'з',
    a = 'ф',
    s = 'ы',
    d = 'в',
    f = 'а',
    g = 'п',
    h = 'р',
    j = 'о',
    k = 'л',
    l = 'д',
    z = 'я',
    x = 'ч',
    c = 'с',
    v = 'м',
    b = 'и',
    n = 'т',
    m = 'ь',
    Q = 'Й',
    W = 'Ц',
    E = 'У',
    R = 'К',
    T = 'Е',
    Y = 'Н',
    U = 'Г',
    I = 'Ш',
    O = 'Щ',
    P = 'З',
    A = 'Ф',
    S = 'Ы',
    D = 'В',
    F = 'А',
    G = 'П',
    H = 'Р',
    J = 'О',
    K = 'Л',
    L = 'Д',
    Z = 'Я',
    X = 'Ч',
    C = 'С',
    V = 'М',
    B = 'И',
    N = 'Т',
    M = 'Ь',
}

---@class Config
---@field cabbrev? table<string> Command-line mode commands to be abbreviated in Russian.
M.defaultConfig = {
    cabbrev = { 'bd', 'bn', 'q', 'qa', 'w', 'wq', 'wqa' },
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
    for _, rhs in ipairs(M.cfg.cabbrev) do
        local lhs = rhs:gsub('[a-zA-Z]', ruChar)
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
