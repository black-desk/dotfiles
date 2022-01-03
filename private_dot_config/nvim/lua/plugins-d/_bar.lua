-- https://github.com/romgrk/barbar.nvim

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
    prefix  = "<space>",
    buffer  = nil, -- Global mappings. Or specify a buffer number for buffer local mappings
    silent  = true, -- use `silent ` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
  }

  wk.register(
    {
      name = "barbar", -- optional group name
      -- Move to previous/next
      k = { "<CMD>BufferPrevious<CR>",     "Move to previous buffer" },
      j = { "<CMD>BufferNext<CR>",         "Move to next buffer" },
      h = { "<CMD>BufferMovePrevious<CR>", "Re-order buffer to previous" },
      l = { "<CMD>BufferMoveNext<CR>",     "Re-order buffer to next" },
      d = { "<CMD>BufferClose<CR>",        "Close buffer" },
      p = { "<CMD>BufferPick<CR>",         "Enter buffer-picking mode" },
    },
    key_opts
  )
end

return {
  'romgrk/barbar.nvim',
  requires = {'kyazdani42/nvim-web-devicons'},
  config = config,
}
