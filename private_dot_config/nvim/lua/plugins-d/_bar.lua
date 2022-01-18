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
    buffer  = nil, -- Global mappings.
    silent  = true,
    noremap = true,
  }

  wk.register(
    {
      k = { "<cmd>BufferPrevious<cr>",     "BAR:: previous buffer" },
      j = { "<cmd>BufferNext<cr>",         "BAR:: next buffer" },
      h = { "<cmd>BufferMovePrevious<cr>", "BAR:: move buffer to previous" },
      l = { "<cmd>BufferMoveNext<cr>",     "BAR:: move buffer to next" },
      d = { "<cmd>BufferClose<cr>",        "BAR:: close buffer" },
      p = { "<cmd>BufferPick<cr>",         "BAR:: buffer-picking mode" },
    },
    key_opts
  )
end

return {
  'romgrk/barbar.nvim',
  requires = {'kyazdani42/nvim-web-devicons'},
  config = config,
}
