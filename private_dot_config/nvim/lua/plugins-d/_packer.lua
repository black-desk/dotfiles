-- https://github.com/wbthomason/packer.nvim

-- Description:
-- plugin manager

local function config()
  local wk = require("which-key")
  local key_opts = {
    -- mode   Help        Affected                              Equivalent
    -- ''     mapmode-nvo Normal/Visual/Select/Operator-pending :map
    -- 'n'    mapmode-n	  Normal                                :nmap
    -- 'v'    mapmode-v   Visual/Select                         :vmap
    -- 's'    mapmode-s	  Select                                :smap
    -- 'x'    mapmode-x	  Visual                                :xmap
    -- 'o'    mapmode-o   Operator-pending                      :omap
    -- '!'    mapmode-ic  Insert/Command-line                   :map!
    -- 'i'    mapmode-i   Insert                                :imap
    -- 'l'    mapmode-l   Insert/Command-line/Lang-Arg          :lmap
    -- 'c'    mapmode-c   Command-line                          :cmap
    -- 't'    mapmode-t   Terminal                              :tmap
    mode    = "n",
    prefix  = "<leader>p",
    buffer  = nil, -- Global mappings.
    silent  = true,
    noremap = true,
  }

  wk.register(
    {
      ['s'] = { '<cmd>PackerSync<cr>', "PACK:: update plugin" },
    },
    key_opts
  )
end

return {
  'wbthomason/packer.nvim',
  config = config,
}
