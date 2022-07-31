-- https://github.com/hrsh7th/nvim-cmp

-- Description:
-- completion setup

local config = function()
        local cmp = require('cmp')
        cmp.setup({
                enabled = function()
                        if vim.api.nvim_get_mode()["mode"] == 'i' then
                                return require("fcitx5-ui").getCurrentIM() == ""
                        end
                end,
                snippet = {
                        -- REQUIRED - you must specify a snippet engine
                        expand = function(args)
                                -- For `ultisnips` users.
                                vim.fn["UltiSnips#Anon"](args.body)
                        end,
                },
                mapping = cmp.mapping.preset.insert({
                        ['<C-b>'] = cmp.mapping(
                                cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
                        ['<C-f>'] = cmp.mapping(
                                cmp.mapping.scroll_docs(4), { 'i', 'c' }),
                        -- Specify `cmp.config.disable` if you want to remove
                        -- the default `<C-y>` mapping.
                        ['<C-y>'] = cmp.config.disable,
                        ["<tab>"] = cmp.mapping.select_next_item(),
                        ["<S-tab>"] = cmp.mapping.select_prev_item(),
                        -- Accept currently selected item. Set `select` to
                        -- `false` to only confirm explicitly selected items.
                        ['<CR>'] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                        { name = 'nvim_lsp' },
                        { name = 'ultisnips' },
                        { name = 'path' },
                        { name = 'buffer' },
                        {
                                name = 'look',
                                keyword_length = 2,
                                option = {
                                        convert_case = true,
                                        loud = true } } })
        })

        -- Use buffer source for `/` (if you enabled `native_menu`, this won't
        -- work anymore).
        cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = { { name = 'buffer' } } })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`,
        -- this won't work anymore).
        cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources(
                        { { name = 'path' } },
                        { { name = 'cmdline' } })
        })

        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        cmp.event:on(
                'confirm_done',
                cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))

        Capabilities = require('cmp_nvim_lsp').update_capabilities(Capabilities)

end

return {
        'hrsh7th/nvim-cmp',
        requires = {
                -- https://github.com/hrsh7th/cmp-nvim-lsp
                'hrsh7th/cmp-nvim-lsp',
                -- https://github.com/hrsh7th/cmp-buffer
                'hrsh7th/cmp-buffer',
                -- https://github.com/hrsh7th/cmp-path
                'hrsh7th/cmp-path',
                -- https://github.com/hrsh7th/cmp-cmdline
                'hrsh7th/cmp-cmdline',
                -- https://github.com/quangnguyen30192/cmp-nvim-ultisnips
                'quangnguyen30192/cmp-nvim-ultisnips',
                -- https://github.com/octaltree/cmp-look
                'octaltree/cmp-look',
        },
        config = config,
}
