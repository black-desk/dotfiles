-- https://github.com/RRethy/vim-illuminate

-- Description:
-- Vim plugin for automatically highlighting other uses of the current word under the cursor

local function config()
        vim.cmd([[
                augroup illuminate_augroup
                        autocmd!
                        autocmd VimEnter * hi illuminatedWord
                        \ cterm=bold gui=bold
                augroup END]])

        require('illuminate').configure({ providers = { 'lsp' }, delay = 500 })
end

return {
        'RRethy/vim-illuminate',
        config = config,
        events = { 'VimEnter' },
        dependencies = { 'neovim/nvim-lspconfig' },
}
