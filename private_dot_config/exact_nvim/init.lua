vim.api.nvim_set_option('ignorecase', true)
vim.opt.clipboard = vim.opt.clipboard + { 'unnamedplus' }

-- tab size
-- FIXME use lua here
vim.cmd([[
        let g:python3_host_prog = os.getenv("PYENV_ROOT")+'/versions/neovim/bin/python'
        set updatetime=100
        set number
        set relativenumber
        set mouse=nv
        set nowrap
        set expandtab tabstop=8 shiftwidth=8 softtabstop=8
        set cursorline " current line
        set hlsearch   " searched key word
        set colorcolumn=81
        set signcolumn=yes
        au Filetype go setlocal noexpandtab
        au Filetype gitcommit setlocal colorcolumn=51,72 tabstop=2 shiftwidth=2 softtabstop=2
        au Filetype markdown setlocal colorcolumn=81 tabstop=2 shiftwidth=2 softtabstop=2
        au Filetype cmake setlocal colorcolumn=81 tabstop=2 shiftwidth=2 softtabstop=2
        au BufNewFile,BufRead *_test.go setlocal colorcolumn= tabstop=2 shiftwidth=2 softtabstop=2
        au Filetype djot setlocal colorcolumn=81 tabstop=2 shiftwidth=2 softtabstop=2
        set foldlevel=99
]])

-- FIXME: use lua here

vim.cmd([[
        let g:mapleader=";"
        " align to right                       https://unix.stackexchange.com/a/260277
        nnoremap <leader>r<tab> mc80A <esc>080lDgelD`cP

        " exit insert mode in terminal
        tnoremap <c-q><c-q> <c-\><c-n>

        " open terminal in new buffer
        noremap <silent> <leader>T :e term://.//zsh<cr>|

        " open global config file in new tab
        noremap <silent> <leader>vimrc :e ~/.config/nvim/init.lua<cr>

        " move cursor up-and-down when line warpped
        "    https://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/clhv03p
        nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
        nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

        " mark
        nnoremap <silent> <leader>lm :marks<cr>
]])

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
