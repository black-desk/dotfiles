local config = function()
        Capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true
        }
        local handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local suffix = ('  %d '):format(endLnum - lnum)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                local curWidth = 0
                for _, chunk in ipairs(virtText) do
                        local chunkText = chunk[1]
                        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        if targetWidth > curWidth + chunkWidth then
                                table.insert(newVirtText, chunk)
                        else
                                chunkText = truncate(chunkText, targetWidth - curWidth)
                                local hlGroup = chunk[2]
                                table.insert(newVirtText, { chunkText, hlGroup })
                                chunkWidth = vim.fn.strdisplaywidth(chunkText)
                                -- str width returned from truncate() may less than 2nd argument, need padding
                                if curWidth + chunkWidth < targetWidth then
                                        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                                end
                                break
                        end
                        curWidth = curWidth + chunkWidth
                end
                table.insert(newVirtText, { suffix, 'MoreMsg' })
                return newVirtText
        end

        -- global handler
        -- `handler` is the 2nd parameter of `setFoldVirtTextHandler`,
        -- check out `./lua/ufo.lua` and search `setFoldVirtTextHandler` for detail.
        require('ufo').setup({
                fold_virt_text_handler = handler
        })

        local function applyFoldsAndThenCloseAllFolds(bufnr, providerName)
                require('async')(function()
                        bufnr = bufnr or vim.api.nvim_get_current_buf()
                        -- make sure buffer is attached
                        require('ufo').attach(bufnr)
                        -- getFolds return Promise if providerName == 'lsp'
                        local ok, ranges = pcall(await, require('ufo').getFolds(bufnr, providerName))
                        if not ok or not ranges then
                                return
                        end
                        ok = require('ufo').applyFolds(bufnr, ranges)
                        if ok then
                                require('ufo').closeAllFolds()
                        end
                end)
        end

        vim.api.nvim_create_autocmd('BufRead', {
                pattern = '*',
                callback = function(e)
                        applyFoldsAndThenCloseAllFolds(e.buf, 'lsp')
                end
        })

end

return {
        'kevinhwang91/nvim-ufo',
        config = config,
        dependencies = { 'kevinhwang91/promise-async' }
}
