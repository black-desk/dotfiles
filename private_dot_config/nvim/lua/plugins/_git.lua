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

        require('gitsigns').setup({
                current_line_blame = true,
                current_line_blame_opts = {
                        virt_text = true,
                        virt_text_pos = 'eol',
                        delay = 300,
                        ignore_whitespace = false,
                },
                keymaps = {},
        })

        local wk = require("which-key")
        local key_opts = {
                mode    = "n",
                prefix  = "<space>g",
                buffer  = nil, -- Global mappings.
                silent  = true,
                noremap = true,
        }

        wk.register({
                ["w"] = {
                        "<cmd>Gitsigns toggle_word_diff<cr>",
                        "GITS:: word diff mode" },
                ["j"] = {
                        "<cmd>Gitsigns next_hunk<cr>",
                        "GITS:: next hunk" },
                ["k"] = {
                        "<cmd>Gitsigns prev_hunk<cr>",
                        "GITS:: previous hunk" },
                ["u"] = {
                        "<cmd>Gitsigns undo_stage_hunk<cr>",
                        "GITS:: undo stage hunk" },
                ["s"] = {
                        "<cmd>Gitsigns stage_hunk<cr>",
                        "GITS:: stage hunk" },
        }, key_opts)
end

return {
        'tpope/vim-fugitive',
        dependencies = {
                -- GBrowser handlers
                {
                        -- https://github.com/tpope/vim-rhubarb
                        'tpope/vim-rhubarb', -- github
                        -- https://github.com/borissov/fugitive-gitea
                        'borissov/fugitive-gitea', -- gitea
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
