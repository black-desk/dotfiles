return {
        'williamboman/mason.nvim',
        config = function()
                require("mason").setup()
                require("mason-lspconfig").setup({
                        automatic_installation = true,
                })
        end,
        dependencies = {
                'williamboman/mason-lspconfig.nvim'
        }
}
