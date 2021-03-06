local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local is_startup = false
if fn.empty(fn.glob(install_path)) > 0 then -- FIXME: why this warning?
        fn.system({
                'git', 'clone', '--depth', '1',
                'https://github.com/wbthomason/packer.nvim',
                install_path })
        vim.cmd [[packadd packer.nvim]]
        is_startup = true
end

return require('packer').startup(
        function()
                local use = require('packer').use
                local home = os.getenv('HOME')
                local plugins = io.popen(
                        'find ' ..
                        '"' ..
                        home .. '/.config/nvim/lua/plugins-d/' ..
                        '"' ..
                        ' -type f')
                if plugins == nil then
                        return
                end

                for plugin in plugins:lines() do
                        local part1, part2 = string.match(
                                plugin,
                                home .. "/[.]config/nvim/lua/(.*)_(.*)[.]lua"
                        )
                        if part1 ~= nil and part2 ~= nil then
                                plugin = part1 .. '_' .. part2
                        else
                                plugin = ''
                        end
                        if plugin ~= '' then
                                use(require(plugin))
                        end
                end
                if is_startup then
                        require('packer').sync()
                end
        end
)
