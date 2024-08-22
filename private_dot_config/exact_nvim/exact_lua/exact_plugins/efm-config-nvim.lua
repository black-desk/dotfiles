local config = function()
        -- Register linters and formatters per language
        local prettierd = require('efmls-configs.formatters.prettier_d')
        local black = require('efmls-configs.formatters.black')
        local clang_tidy = require('efmls-configs.linters.clang_tidy')
        local languages = {
                markdown = { prettierd },
                python = { black },
                c = { clang_tidy },
                cpp = { clang_tidy },
        }

        -- Or use the defaults provided by this plugin
        -- check doc/SUPPORTED_LIST.md for the supported languages
        --
        -- local languages = require('efmls-configs.defaults').languages()

        local efmls_config = {
                filetypes = vim.tbl_keys(languages),
                settings = {
                        rootMarkers = { '.git/', 'build/compile_commands.json' },
                        languages = languages,
                },
                init_options = {
                        documentFormatting = true,
                        documentRangeFormatting = true,
                },
        }

        require('lspconfig').efm.setup(vim.tbl_extend('force', efmls_config, {
                on_attach = On_Attach,
                capabilities = Capabilities,
        }))
end

return {
        'creativenull/efmls-configs-nvim',
        dependencies = { 'neovim/nvim-lspconfig' },
        config = config,
}
