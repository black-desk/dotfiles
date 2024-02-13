vim.g.python3_host_prog = vim.env.PYENV_ROOT .. '/versions/neovim/bin/python'
vim.g.mapleader = ';'

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
        '', '<leader>T', ':e term://.//zsh<cr>i',
        {
                desc = "open terminal in new buffer",
                silent = true
        })
vim.keymap.set(
        '', '<leader>vimrc', ':e ~/.config/nvim/init.lua<cr>',
        {
                desc = "open global config file in new tab",
                silent = true
        })
vim.keymap.set(
        'n', '<leader>lm', ':marks<cr>', { silent = true }
)

table.unpack = table.unpack or unpack
table.pack = table.pack or pack

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
                "git",
                "clone",
                "--filter=blob:none",
                "https://github.com/folke/lazy.nvim.git",
                "--branch=stable",
                lazypath,
        })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {})
