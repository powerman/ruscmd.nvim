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
}

---@param ascii string String with ASCII symbols.
---@return string ru Value of ascii with every English letter replaced by Russian letter at same key.
M.ru = function(ascii)
    local ru, _ = ascii:gsub('[a-zA-Z]', en2ru)
    return ru
end

return M
