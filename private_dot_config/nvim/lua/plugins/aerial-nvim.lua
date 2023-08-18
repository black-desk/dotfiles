local function config()
        require("aerial").setup()

        local set_keymap = function(lhs, rhs, desc)
                local desc_prefix = "[aerial] "
                vim.keymap.set(
                        "n", lhs, rhs,
                        { ["desc"] = desc_prefix .. desc }
                )
        end

        set_keymap("t", "<cmd>AerialToggle<cr>", "toggle outline")
end

return {
        'stevearc/aerial.nvim',
        config = config,
        dependencies = {
                "nvim-lspconfig"
        }
}
