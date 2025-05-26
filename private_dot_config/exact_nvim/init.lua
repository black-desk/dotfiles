-- =============================================================================
-- Compatibility setup
-- =============================================================================

-- > Function unpack was moved into the table library
-- > and therefore must be called as table.unpack.
-- Reference: https://www.lua.org/manual/5.2/manual.html
table.unpack = table.unpack or unpack -- NOLINT

-- > Remove at Nvim 1.0
-- > @deprecated
-- > vim.loop = vim.uv
-- Reference: https://github.com/neovim/neovim/blob/410cf29ee6a5d41a90d71d4d6d1fc84b5fe503e5/runtime/lua/vim/_editor.lua#L1127-L1129
vim.uv = vim.uv or vim.loop -- NOLINT

-- =============================================================================
-- Utilities
-- =============================================================================

local utils = {}

do
        local function run_command(command, trace_message, exit)
                vim.api.nvim_echo({
                        { "Running command to " .. trace_message .. "..." },
                }, true, {})

                local out = vim.fn.system(command)
                if vim.v.shell_error == 0 then
                        return out, true
                end

                vim.api.nvim_echo({
                        { "Failed to " .. trace_message .. ":\n", "ErrorMsg" },
                        { out .. "\n",                            "WarningMsg" },
                }, true, {})
                if not exit then
                        return out, false
                end

                vim.api.nvim_echo({
                        { "Press any key to exit..." },
                }, true, {})
                vim.fn.getchar()
                os.exit(1)
        end

        local set_local_tabsize = function(size)
                return function()
                        vim.opt_local.tabstop = size
                        vim.opt_local.shiftwidth = size
                        vim.opt_local.softtabstop = size
                end
        end

        local enable_wrap = function()
                vim.opt.wrap = true
                vim.keymap.set({ 'n', 'v' }, 'j', 'gj', { buffer = true })
                vim.keymap.set({ 'n', 'v' }, 'k', 'gk', { buffer = true })
        end

        utils = {
                shell = {
                        run_command = run_command
                },
                vim = {
                        set_local_tabsize = set_local_tabsize,
                        enable_wrap = enable_wrap
                }
        }
end

-- Setup python for neovim.
local function setup_python()
        -- If pyenv is not installed or anything goes wrong,
        -- we will just return, which means to use system provided python.

        if not vim.env.PYENV_ROOT then
                return
        end

        local pyenv = require("pyenv")

        local python3_host_prog =
            vim.env.PYENV_ROOT .. '/versions/neovim/bin/python'

        if pyenv.check_python_version('neovim') then
                vim.g.python3_host_prog = python3_host_prog
                return
        end

        if not pyenv.ensure_python_version('miniforge3-latest') then
                return
        end

        if not pyenv.ensure_plugin(
                    'pyenv-virtualenv',
                    'https://github.com/pyenv/pyenv-virtualenv'
            ) then
                return
        end

        if not shell.run_command(
                    {
                            'pyenv', 'virtualenv',
                            'miniforge3-latest', 'neovim',
                    },
                    'create virtualenv "neovim" ' ..
                    'from "miniforge3-latest"',
                    false
            ) then
                return
        end

        if not shell.run_command(
                    {
                            'env', 'PYENV_VERSION=neovim',
                            'pyenv', 'exec', 'pip', 'install', 'neovim',
                    },
                    'install neovim in virtualenv "neovim"',
                    false) then
                return
        end

        vim.g.python3_host_prog = python3_host_prog
end
setup_python()


-- =============================================================================
-- Global configuration
-- =============================================================================

vim.g.mapleader = ";"
vim.g.maplocalleader = "<space>"
vim.opt.spell = true
vim.opt.spelllang = { 'en_us' }
vim.opt.clipboard = vim.opt.clipboard + { 'unnamedplus' }
vim.opt.ignorecase = true
vim.opt.updatetime = 100
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'nv'
vim.opt.wrap = false
vim.opt.expandtab = true
vim.opt.tabstop = 8
vim.opt.shiftwidth = 8
vim.opt.softtabstop = 8
vim.opt.cursorline = true
vim.opt.hlsearch = true
vim.opt.colorcolumn = '81'
vim.opt.signcolumn = 'yes'
vim.opt.foldlevel = 99
local auto_view_pattern = {
        "*.c",
        "*.cpp",
        "*.hpp",
        "*.json",
        "*.lua",
        "*.md",
        "*.rs",
}

-- Language specific configurations

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
        pattern = '*.dj',
        callback = function()
                vim.opt_local.filetype = "djot"
        end
})

vim.api.nvim_create_autocmd('Filetype', {
        pattern = { 'djot' },
        callback = function()
                if vim.opt_local.columns:get() > 72 then
                        vim.opt_local.columns = 72
                end
                utils.vim.enable_wrap()
                vim.opt_local.colorcolumn = { 73 }
        end
})

vim.api.nvim_create_autocmd('Filetype', {
        pattern = { 'markdown' },
        callback = function()
                vim.print(vim.opt_local.columns)
                if vim.opt_local.columns:get() > 80 then
                        vim.opt_local.columns = 80
                end
                utils.vim.enable_wrap()
                vim.opt_local.colorcolumn = { 81 }
        end
})

vim.api.nvim_create_autocmd('Filetype', {
        pattern = { 'go' },
        callback = function() vim.opt_local.expandtab = false end
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
        pattern = '*_test.go',
        callback = function()
                vim.opt_local.colorcolumn = ''
                utils.vim.set_local_tabsize(2)()
        end
})

vim.api.nvim_create_autocmd('Filetype', {
        pattern = { "sh" },
        callback = function() vim.opt_local.expandtab = false end
})

vim.api.nvim_create_autocmd('Filetype', {
        pattern = 'rust',
        callback = function()
                if vim.opt_local.columns:get() > 100 then
                        vim.opt_local.columns = 100
                end
                vim.opt_local.colorcolumn = 101 end
})

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
        pattern = '*.pmd',
        callback = function() vim.opt_local.filetype = 'markdown' end
})

vim.api.nvim_create_autocmd('Filetype', {
        pattern = 'gitcommit',
        callback = function()
                if vim.opt_local.columns:get() > 72 then
                        vim.opt_local.columns = 72
                end
                utils.vim.enable_wrap()
                vim.opt_local.colorcolumn = {51, 72} end
})

vim.api.nvim_create_autocmd('Filetype', {
        pattern = { 'gitcommit', 'markdown', 'cmake', 'djot' },
        callback = utils.vim.set_local_tabsize(2)
})

vim.api.nvim_create_autocmd('Filetype', {
        pattern = { 'typst' },
        callback = function()
                if vim.opt_local.columns:get() > 80 then
                        vim.opt_local.columns = 80
                end
                utils.vim.enable_wrap()
        end
})

-- Auto view

local auto_view_aug = vim.api.nvim_create_augroup("auto_view", { clear = true })

vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
        group = auto_view_aug,
        pattern = auto_view_pattern,
        callback = function() vim.cmd("silent! mkview") end
})
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
        group = auto_view_aug,
        pattern = auto_view_pattern,
        callback = function() vim.cmd("silent! loadview") end
})


-- https://unix.stackexchange.com/a/260277
vim.keymap.set(
        'n', '<leader><tab><tab>', 'mc80A <esc>080lDgelD`cP',
        { desc = "align to right" })
vim.keymap.set(
        't', '<ESC><ESC>', '<c-\\><c-n>',
        { desc = "exit insert mode in terminal" })
vim.keymap.set(
        '', '<leader>T', function() vim.cmd.terminal() end,
        {
                desc = "open terminal in new buffer",
                silent = true
        })
vim.keymap.set(
        '', '<leader>vimrc', ':cd ~/.config/nvim<cr>:e ~/.config/nvim/init.lua<cr>',
        {
                desc = "open global config file in new tab",
                silent = true
        })

vim.keymap.set(
        'n', '<leader>lm', ':marks<cr>', { silent = true }
)

vim.keymap.set(
        'n', '<leader>R', function()
                local line = vim.api.nvim_get_current_line()
                local ok, _, command = line:find('shell: `(.+)`')
                if ok == nil then
                        vim.print("No command found")
                        return
                end
                vim.cmd(':r !' .. command)
        end,
        {
                desc = 'Run command in current line and insert its output.',
                silent = true
        }
)

-- =============================================================================
-- Setup lazy.nvim
-- =============================================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

if not vim.uv.fs_stat(lazypath) then
        local lazyrepo = "https://github.com/folke/lazy.nvim.git"
        utils.shell.run_command(
                {
                        "git", "clone", "--filter=blob:none", "--branch=stable",
                        lazyrepo, lazypath,
                },
                "clone lazy.nvim", true
        )
end

require("lazy").setup({
        spec = {
                -- import your plugins
                { import = "plugins" },
        },
        -- Configure any other settings here. See the documentation for more details.
        -- colorscheme that will be used when installing plugins.
        install = { missing = true, colorscheme = { "habamax" } },
})

