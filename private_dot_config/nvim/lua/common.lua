vim.api.nvim_set_option('ignorecase', true)
vim.opt.clipboard = vim.opt.clipboard + { 'unnamedplus' }

-- tab size
-- FIXME use lua here
vim.cmd([[
        set updatetime=100
        set number
        set relativenumber
        set mouse=nv
        set expandtab tabstop=8 shiftwidth=8 softtabstop=8
        set cursorline " current line
        set hlsearch   " searched key word
        set colorcolumn=81
        set signcolumn=yes
        au Filetype gitcommit setlocal colorcolumn=72
]])
