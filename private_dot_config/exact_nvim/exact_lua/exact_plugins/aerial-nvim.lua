-- https://github.com/stevearc/aerial.nvim

local function init()
        local set_keymap = function(lhs, rhs, desc)
                local desc_prefix = "[aerial] "
                vim.keymap.set(
                        "n", lhs, rhs,
                        { ["desc"] = desc_prefix .. desc }
                )
        end

        set_keymap("t", "<cmd>AerialToggle<cr>", "toggle outline")
end

local function config()
        require("aerial").setup()
end

return {
        'stevearc/aerial.nvim',
        init = init,
        config = config,
        cmd = {
                'AerialToggle',
        }
}
