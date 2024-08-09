local mappings = require('plugins.misc.nvim-tree-mappings')

return {
  "kyazdani42/nvim-tree.lua",
  opts = {
    on_attach = mappings.on_attach,
    hijack_cursor = true,
    sort = {
      sorter = 'extension',
    },
    sync_root_with_cwd = true,
    actions = {
      open_file = {
        quit_on_open = false,
      },
    },
    filters = {
      custom = {
        '.aux',
        '.fdb_latexmk ',
        '.fls ',
        '.synctex.gz ',
        '__init__.py',
        '.null-ls'
      }
    },
    renderer = {
      indent_width = 2,
      root_folder_label = false,
      indent_markers = {
        enable = true,
      },
      icons = {
        webdev_colors = true,
        git_placement = "after",
        padding = " ",
        symlink_arrow = " ➛ ",
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
        glyphs = {
          default = "",
          symlink = "",
          folder = {
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = "",
            symlink_open = "",
          },
          git = {
            unstaged = "",
            staged = "S",
            unmerged = "",
            renamed = "➜",
            untracked = "U",
            deleted = "",
            ignored = "◌",
          },
        },
      },
    },
    view = {
      width = 35,
      signcolumn = "yes",
    },
  }
}
