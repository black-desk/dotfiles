-- https://github.com/kyazdani42/nvim-tree.lua

-- Description:
-- file explorer

local function config()
  vim.g.nvim_tree_refresh_wait = 500 -- 1000 by default, control how often the tree can be refreshed, 1000 means the tree can be refresh once per 1000ms.
  local tree_cb = require 'nvim-tree.config'.nvim_tree_callback
  local list = {
    { key = "l", cb = tree_cb("edit") },
    { key = "L", cb = tree_cb("cd") },
    { key = "h", cb = tree_cb("close_node") },
    { key = "<Tab>", cb = tree_cb("preview") },
    { key = "K", cb = tree_cb("first_sibling") },
    { key = "J", cb = tree_cb("last_sibling") },
    { key = "H", cb = tree_cb("toggle_dotfiles") },
    { key = "R", cb = tree_cb("refresh") },
    { key = "a", cb = tree_cb("create") },
    { key = "D", cb = tree_cb("remove") },
    { key = "d", cb = tree_cb("trash") },
    { key = "r", cb = tree_cb("rename") },
    { key = "x", cb = tree_cb("cut") },
    { key = "c", cb = tree_cb("copy") },
    { key = "p", cb = tree_cb("paste") },
    { key = "y", cb = tree_cb("copy_name") },
    { key = "Y", cb = tree_cb("copy_path") },
    { key = "<C-y>", cb = tree_cb("copy_absolute_path") },
    { key = "gk", cb = tree_cb("prev_git_item") },
    { key = "gj", cb = tree_cb("next_git_item") },
    { key = "..", cb = tree_cb("dir_up") },
    { key = "s", cb = tree_cb("system_open") },
    { key = "q", cb = tree_cb("close") },
    { key = "g?", cb = tree_cb("toggle_help") },
  }

  -- FIXME use lua here
  vim.cmd([[
    nnoremap <silent> <leader>e :NvimTreeToggle<CR>
  ]])

  require('nvim-tree').setup {
    create_in_closed_folder = false,
    disable_netrw           = false,
    hijack_netrw            = true,
    open_on_setup           = false,
    ignore_ft_on_setup      = {},
    open_on_tab             = false,
    hijack_cursor           = true,
    update_cwd              = true,
    hijack_directories      = {
      enable = true,
      auto_open = true,
    },
    renderer                = {
      highlight_opened_files = "all",
      highlight_git = true,
      indent_markers = {
        enable = true,
      },
      add_trailing = true,
      special_files = {
        -- FIXME special files lose filetype related icon, disable this for now
        --[[
        ["README.md"] = true,
        ["Makefile"] = true,
        ["MAKEFILE"] = true,
        ["CMakeLists.txt"] = true,
        ["meson.build"] = true,
        ["*main*"] = true,
        ]]
      },
      icons = {
        glyphs = {
          default = '',
          git = {
            unstaged = "✗",
            staged = "✓",
            unmerged = "",
            renamed = "➜",
            untracked = "★",
            deleted = "",
            ignored = "~"
          },
        },
        show = {
          git = true,
          folder = true,
          file = true,
          folder_arrow = false,
        },
      },
    },
    diagnostics             = {
      enable = true,
      icons = {
        hint = "",
        info = "",
        warning = "",
        error = "",
      }
    },
    update_focused_file     = {
      enable      = true,
      update_cwd  = true,
      ignore_list = {}
    },
    system_open             = {
      cmd  = nil,
      args = {}
    },
    filters                 = {
      dotfiles = true,
      custom = {}
    },
    git                     = {
      enable = true,
      ignore = false,
      timeout = 500,
    },
    view                    = {
      width = 30,
      height = 30,
      hide_root_folder = false,
      side = 'left',
      mappings = {
        custom_only = true,
        list = list,
      },
      number = true,
      relativenumber = true,
      signcolumn = "no"
    },
    trash                   = {
      cmd = "trash",
      require_confirm = true
    },
    actions                 = {
      open_file = {
        window_picker = {
          enable = true,
          exclude = {
            filetype = {
              'notify',
              'packer',
              'qf'
            },
            buftype = {
              'terminal',
            },
          },
        },
        quit_on_open = true,
        resize_window = false,
      },
    },
  }
end

return {
  'kyazdani42/nvim-tree.lua',
  commit = "0373680819c5bd29b912b51b7119de96049a6bcc",
  requires = {
    -- https://github.com/kyazdani42/nvim-web-devicons
    'kyazdani42/nvim-web-devicons', -- icon
  },
  config = config,
}
