-- https://github.com/hrsh7th/nvim-cmp

-- Description:
-- completion setup

local config = function()
        local cmp = require('cmp')
        local compare = require 'cmp.config.compare'
        cmp.setup({
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
                        ["<tab>"] = cmp.mapping.select_next_item(),
                        ["<S-tab>"] = cmp.mapping.select_prev_item(),
                        -- Accept currently selected item. Set `select` to
                        -- `false` to only confirm explicitly selected items.
                        ['<C-e>'] = cmp.mapping.abort(),
                        ['<Space>'] = cmp.mapping(function(fallback)
                                local entry = cmp.get_selected_entry()
                                if entry == nil then
                                        entry = cmp.core.view:get_first_entry()
                                end
                                if entry and entry.source.name == "nvim_lsp"
                                    and entry.source.source.client.name == "rime_ls" then
                                        cmp.confirm({
                                                behavior = cmp.ConfirmBehavior.Replace,
                                                select = true,
                                        })
                                else
                                        fallback()
                                end
                        end, { 'i', 's' }),
                        ['<CR>'] = cmp.mapping(function(fallback)
                                local entry = cmp.get_selected_entry()
                                if entry == nil then
                                        entry = cmp.core.view:get_first_entry()
                                end
                                if entry and entry.source.name == 'nvim_lsp'
                                    and entry.source.source.client.name == 'rime_ls' then
                                        cmp.abort()
                                else
                                        if entry ~= nil then
                                                cmp.confirm({
                                                        behavior = cmp.ConfirmBehavior.Replace,
                                                        select = true
                                                })
                                        else
                                                fallback()
                                        end
                                end
                        end, { 'i', 's' }),
                }),
                sources = cmp.config.sources({
                        { name = 'ultisnips' },
                },{
                        { name = 'nvim_lsp' },
                        { name = "copilot", priority = 50 },
                        {
                                name = 'look',
                                keyword_length = 2,
                                option = {
                                        convert_case = true,
                                        loud = true
                                }
                        },
                }, {
                        { name = 'path' },
                }),
                enabled = function()
                        if vim.bo.ft == 'TelescopePrompt' then
                                return false
                        end

                        local ret, fcitx5ui = pcall(require, 'fcitx5-ui')
                        if not ret then
                                return true
                        end

                        return fcitx5ui.get_current_input_method_status().name == nil
                end,
                sorting = {
                        comparators = {
                                compare.sort_text,
                                compare.offset,
                                compare.exact,
                                compare.score,
                                compare.recently_used,
                                compare.kind,
                                compare.length,
                                compare.order,
                        }
                },
        })

        -- Use buffer source for `/` (if you enabled `native_menu`, this won't
        -- work anymore).
        cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = { { name = 'buffer' } }
        })

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
end

return { {
        'hrsh7th/nvim-cmp',
        config = config,
}, {
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
}, }
