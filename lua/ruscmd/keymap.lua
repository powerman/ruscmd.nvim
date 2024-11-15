local M = {}

local en2ru = {
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
    ['`'] = 'ё',
    ['~'] = 'Ё',
    ['['] = 'х',
    ['{'] = 'Х',
    [']'] = 'ъ',
    ['}'] = 'Ъ',
    [';'] = 'ж',
    [':'] = 'Ж',
    ["'"] = 'э',
    ['"'] = 'Э',
    [','] = 'б',
    ['<'] = 'Б',
    ['.'] = 'ю',
    ['>'] = 'Ю',
}

--- Returns string with all English layout symbols replaced by Russian layout symbols.
---
---@param ascii string
---@return string
M.ru = function(ascii)
    local ru, _ = ascii:gsub('.', en2ru)
    return ru
end

--- Returns same {lhs} map key sequence with English layout keys replaced by Russian layout keys.
---
---@param lhs string
---@return string
M.lhsRu = function(lhs)
    if lhs:sub(1, 6) == '<Plug>' or lhs:sub(1, 5) == '<SNR>' then
        return lhs
    end

    local lhsRu = ''
    while #lhs > 0 do
        local _, endKeycode = lhs:find '^%b<>'
        local _, endKeys = lhs:find '^[^<]+'
        if endKeycode ~= nil then
            local keycode = lhs:sub(1, endKeycode)
            if keycode:lower() == '<lt>' then
                lhsRu = lhsRu .. en2ru['<']
            else
                lhsRu = lhsRu .. keycode
            end
            lhs = lhs:sub(endKeycode + 1)
        elseif endKeys ~= nil then
            lhsRu = lhsRu .. lhs:sub(1, endKeys):gsub('.', en2ru)
            lhs = lhs:sub(endKeys + 1)
        else -- unbalanced "<" means invalid {lhs} but let's handle it anyway
            lhsRu = lhsRu .. lhs:sub(1, 1)
            lhs = lhs:sub(2)
        end
    end
    return lhsRu
end

return M
