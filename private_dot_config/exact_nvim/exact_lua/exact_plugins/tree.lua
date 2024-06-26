-- https://github.com/nvim-neo-tree/neo-tree.nvim

-- Description:
-- file explorer

local function config()
        require("neo-tree").setup({
                window = {
                        width = 30,
                        mappings = {
                                ["l"] = 'open',
                                ["h"] = 'close_node',
                        },
                },
                filesystem = {
                        follow_current_file = { enable = true },
                        filtered_items = {
                                visible = true,
                                never_show = {
                                        ".git",
                                },
                        },
                        window = {
                                mappings = {
                                        ["L"] = "set_root",
                                        ["H"] = "navigate_up",
                                },
                        },
                },
        })
        vim.cmd([[
                nnoremap <silent> <leader>e :Neotree position=float reveal_force_cwd<CR>
        ]])
end

return {
        'nvim-neo-tree/neo-tree.nvim',
        dependencies = {
                -- https://github.com/kyazdani42/nvim-web-devicons
                'nvim-tree/nvim-web-devicons', -- icon
                'nvim-lua/plenary.nvim',
                'MunifTanjim/nui.nvim',
        },
        config = config,
}
