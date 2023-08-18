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
                }
        })

        local set_keymap = function(lhs, rhs, desc)
                local desc_prefix = "[gitsigns] "
                local lhs_prefix = "<space>g"
                vim.keymap.set(
                        "n", lhs_prefix .. lhs, rhs,
                        { ["desc"] = desc_prefix .. desc }
                )
        end

        set_keymap("w", "<cmd>Gitsigns toggle_word_diff<cr>", "toggle word diff mode")
        set_keymap("j", "<cmd>Gitsigns next_hunk<cr>", "next hunk")
        set_keymap("k", "<cmd>Gitsigns previous_hunk<cr>", "previous hunk")
        set_keymap("u", "<cmd>Gitsigns undo_stage_hunk<cr>", "undo stage hunk")
        set_keymap("s", "<cmd>Gitsigns stage_hunk<cr>","stage hunk")
        set_keymap("r", "<cmd>Gitsigns reset_hunk<cr>","reset hunk")
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
