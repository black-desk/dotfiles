-- https://github.com/nvim-treesitter/nvim-treesitter

local function config()
        require 'nvim-treesitter.configs'.setup {
                -- One of "all", or a list of languages
                ensure_installed = { 'c', 'cpp' },

                -- Install languages synchronously (only applied to
                -- `ensure_installed`)
                sync_install = true,

                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                auto_install = true,

                -- List of parsers to ignore installing
                ignore_install = {},

                highlight = {
                        -- `false` will disable the whole extension
                        enable = true,

                        -- list of language that will be disabled
                        disable = {
                                'cpp',
                                'c',
                                'rust',
                        },

                        -- Setting this to true will run `:h syntax` and
                        -- tree-sitter at the same time. Set this to `true` if
                        -- you depend on 'syntax' being enabled (like for
                        -- indentation). Using this option may slow down your
                        -- editor, and you may see some duplicate highlights.
                        -- Instead of true it can also be a list of languages
                        additional_vim_regex_highlighting = false,
                },
        }
end

return {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = config,
}
