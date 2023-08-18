-- https://github.com/preservim/nerdcommenter

-- Description:
-- quick comment plugin

local function config()
        local set_keymap = function(lhs, rhs, desc)
                local desc_prefix = "[nerdcommenter] "
                vim.keymap.set(
                        { "n", "v" }, lhs, rhs,
                        { ["desc"] = desc_prefix .. desc }
                )
        end

        vim.g.NERDSpaceDelims = 1
        vim.g.NERDCreateDefaultMappings = 0

        set_keymap("", "<Plug>NERDCommenterToggle", "toggle comment")
        set_keymap("<C-/>", "<Plug>NERDCommenterToggle", "toggle comment")
end

return {
        'preservim/nerdcommenter',
        config = config,
}
