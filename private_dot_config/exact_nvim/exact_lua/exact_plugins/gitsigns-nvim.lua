-- https://github.com/lewis6991/gitsigns.nvim

local function config ()
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
        'lewis6991/gitsigns.nvim', -- sign column diff mark
        dependencies = {
                'plenary.nvim',
                "vim-fugitive",
        },
        config = config,
}
