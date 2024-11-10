local M = {}

function M.setup()
    local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
    if not vim.uv.fs_stat(lazypath) then
        local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
        vim.api.nvim_echo({ { 'Cloning lazy.nvim\n\n', 'DiagnosticInfo' } }, true, {})
        local ok, out = pcall(
            vim.fn.system,
            { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
        )
        if not ok or vim.v.shell_error ~= 0 then
            vim.api.nvim_echo({
                { 'Failed to clone lazy.nvim\n', 'ErrorMsg' },
                { vim.trim(out or ''), 'WarningMsg' },
                { '\nPress any key to exit...', 'MoreMsg' },
            }, true, {})
            vim.fn.getchar()
            os.exit(1)
        end
    end
    vim.opt.rtp:prepend(lazypath)
end

return M
