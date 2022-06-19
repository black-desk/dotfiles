-- https://github.com/MarcWeber/vim-addon-local-vimrc

-- Description:
-- kiss local vimrc with hash protection

local function config()
        vim.g.local_vimrc = {
                names = {
                        '.vimrc'
                },
                hash_fun = 'LVRHashOfFile',
        }
end

return {
        'MarcWeber/vim-addon-local-vimrc',
        config = config,
}
