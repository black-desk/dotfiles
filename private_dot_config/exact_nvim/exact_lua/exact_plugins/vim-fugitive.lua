-- https://github.com/tpope/vim-fugitive

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
        },
        config = config,
}
