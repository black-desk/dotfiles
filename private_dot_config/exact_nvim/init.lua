-- My neovim configuration file.

require('compatibility')
local shell = require('shell')

-- Bootstrap lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
        local lazyrepo = "https://github.com/folke/lazy.nvim.git"
        shell.run_command(
                {
                        "git", "clone", "--filter=blob:none", "--branch=stable",
                        lazyrepo, lazypath,
                },
                "clone lazy.nvim", true
        )
end
vim.opt.rtp:prepend(lazypath)

local function setup_python()
        if not vim.env.PYENV_ROOT then
                return
        end

        local pyenv = require("pyenv")

        if not pyenv.ensure_python_version('miniforge3-latest') then
                return
        end

        local create_neovim_virtualenv = function()
                local command = {
                        'pyenv', 'virtualenv', 'miniforge3-latest', 'neovim',
                }

                if not shell.run_command(
                            command,
                            'create virtualenv "neovim" ' ..
                            'from "miniforge3-latest"',
                            false
                    ) then
                        return false
                end

                return shell.run_command(
                        {
                                'env', 'PYENV_VERSION=neovim',
                                'pyenv', 'exec', 'pip', 'install', 'neovim',
                        },
                        'install neovim in virtualenv "neovim"',
                        false)
        end

        if not pyenv.ensure_python_version(
                    'neovim',
                    create_neovim_virtualenv
            ) then
                return
        end

        vim.g.python3_host_prog =
            vim.env.PYENV_ROOT .. '/versions/neovim/bin/python'
end

setup_python()

-- Global configuration

vim.g.mapleader = ";"
vim.g.maplocalleader = "<space>"

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

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
        pattern = '*.dj',
        callback = function() vim.opt_local.filetype = "djot" end
})

vim.api.nvim_create_autocmd('Filetype', {
        pattern = 'go',
        callback = function() vim.opt_local.expandtab = false end
})

vim.api.nvim_create_autocmd('Filetype', {
        pattern = 'gitcommit',
        callback = function() vim.opt_local.colorcolumn = '51,72' end
})

local set_local_tabsize = function(size)
        return function()
                vim.opt_local.tabstop = size
                vim.opt_local.shiftwidth = size
                vim.opt_local.softtabstop = size
        end
end

vim.api.nvim_create_autocmd('Filetype', {
        pattern = { 'gitcommit', 'markdown', 'cmake', 'djot' },
        callback = set_local_tabsize(2)
})

vim.api.nvim_create_autocmd('Filetype', {
        pattern = { 'gitcommit', 'markdown', 'cmake', 'djot' },
        callback = set_local_tabsize(2)
})

vim.api.nvim_create_autocmd('Filetype', {
        pattern = { 'typst' },
        callback = function()
                vim.opt_local.wrap = true
                vim.keymap.set('n', 'j', 'gj')
                vim.keymap.set('n', 'k', 'gk')
        end
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
        pattern = '*_test.go',
        callback = function()
                vim.opt_local.colorcolumn = ''
                set_local_tabsize(2)()
        end
})

-- https://unix.stackexchange.com/a/260277
vim.keymap.set(
        'n', '<leader><tab><tab>', 'mc80A <esc>080lDgelD`cP',
        { desc = "align to right" })
vim.keymap.set(
        't', '<c-q><c-q>', '<c-\\><c-n>',
        { desc = "exit insert mode in terminal" })
vim.keymap.set(
        '', '<leader>T', function() vim.cmd.terminal() end,
        {
                desc = "open terminal in new buffer",
                silent = true
        })
if vim.fn.getregion ~= nil then
        vim.keymap.set(
                'v', '<leader>T', function()
                        local get_current_selected_text = function()
                                return vim.fn.getregion(
                                        vim.fn.getcharpos("'<"),
                                        vim.fn.getcharpos("'>")
                                )
                        end

                        local strings = get_current_selected_text()
                        local command = table.concat(strings, ' ')
                        vim.cmd.terminal(command)
                end,
                {
                        desc = "open terminal in new buffer",
                        silent = true
                })
end

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
                local ok, _, command = line:find('shell: `(.+)`$')
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

-- Setup lazy.nvim
require("lazy").setup({
        spec = {
                -- import your plugins
                { import = "plugins" },
        },
        -- Configure any other settings here. See the documentation for more details.
        -- colorscheme that will be used when installing plugins.
        install = { missing = true, colorscheme = { "habamax" } },
        -- automatically check for plugin updates
        checker = { enabled = true },
        dev = {
                path = "~/Documents/workspace/repos/source",
                patterns = { "black-desk" },
                fallback = true,
        }

})
