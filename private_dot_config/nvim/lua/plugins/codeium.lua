return {
        "jcdickinson/codeium.nvim",
        dependencies = {
                "nvim-lua/plenary.nvim",
                "MunifTanjim/nui.nvim",
        },
        config = function()
                require("codeium").setup({})
        end
}
