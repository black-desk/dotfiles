-- https://github.com/romgrk/barbar.nvim

local function config()
        local set_keymap = function(lhs, rhs, desc)
                local desc_prefix = "[barbar] "
                local lhs_prefix = "<space>"
                vim.keymap.set(
                        "n", lhs_prefix .. lhs, rhs,
                        { ["desc"] = desc_prefix .. desc }
                )
        end

        set_keymap("k", "<cmd>BufferPrevious<cr>", "previous buffer")
        set_keymap("j", "<cmd>BufferNext<cr>", "next buffer")
        set_keymap("h", "<cmd>BufferMovePrevious<cr>", "move buffer to previous")
        set_keymap("l", "<cmd>BufferMoveNext<cr>", "move buffer to next")
        set_keymap("d", "<cmd>BufferClose<cr>", "close buffer")
        set_keymap("p", "<cmd>BufferPick<cr>", "pick buffer")
end

return {
        'romgrk/barbar.nvim',
        dependencies = {
                'nvim-web-devicons',
        },
        config = config,
}
