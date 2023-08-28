-- https://github.com/tpope/vim-fugitive

-- Description:
-- git setup

local function config()
        vim.g.fugitive_gitea_domains = {
                'https://gitea.black-desk.cn',
                'https://gitea.io',
        }
        vim.g.fugitive_gitlab_domains = {
                'https://salsa.debian.org',
                'https://whgitlab.uniontech.com',
        }
end

return {
        'tpope/vim-fugitive',
        dependencies = {
                -- GBrowser handlers
                {
                        -- https://github.com/tpope/vim-rhubarb
                        'tpope/vim-rhubarb',             -- github
                        -- https://github.com/borissov/fugitive-gitea
                        'borissov/fugitive-gitea',       -- gitea
                        -- https://github.com/shumphrey/fugitive-gitlab.vim
                        'shumphrey/fugitive-gitlab.vim', -- gitlab
                },
                {
                        -- https://github.com/lewis6991/gitsigns.nvim
                        'lewis6991/gitsigns.nvim', -- sign column diff mark
                        requires = {
                                'nvim-lua/plenary.nvim',
                        },
                },
        },
        config = config,
}
