local function config()
        vim.keymap.set("n", "<space>e",
                function()
                        require("trouble").toggle("diagnostics")
                end,
                { ["desc"] = "toggle trouble diagnostics" })
end

return {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = config,
}
