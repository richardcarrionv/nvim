return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local telescope_ignore = require('plugins.misc.telescope-ignore')
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    telescope.setup {
      defaults = {
        scroll_strategy = "limit",
        path_display = function(opts, path)
          local tail = require("telescope.utils").path_tail(path)
          return string.format("%s [%s]", tail, path)
        end,
        file_ignore_patterns = telescope_ignore.ignored_files,
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-l>"] = actions.send_selected_to_loclist,
            ["<C-h>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-]>"] = actions.close,
          },
          n = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-l>"] = actions.send_selected_to_loclist,
            ["<C-h>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["k"] = actions.move_selection_previous,
            ["j"] = actions.move_selection_next,
            ["l"] = actions.send_selected_to_loclist,
            ["<leader>q"] = actions.close,
            ["q"] = actions.close,
            ["t"] = actions.select_tab,
          }
        },
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          width = 0.9,
          prompt_position = "top",
        }
      },
      pickers = {
        find_files = {
          hidden = true,
        },
        resume = {
          initial_mode = "normal",
        },
        live_grep = {
          layout_strategy = "horizontal",
          layout_config = {
            prompt_position = "top",
            height = 0.8,
            width = 0.8,
            preview_width = 0.4,
          },
          path_display = function(opts, path)
            local tail = require("telescope.utils").path_tail(path)
            return string.format("%s", tail)
          end,
        },
        buffers = {
          initial_mode = "normal",
          theme = "dropdown",
          previewer = false,
          sorting_strategy = "ascending",
        },

        lsp_references = {
          initial_mode = "normal",
          show_line = true,
        },

        lsp_definitions = {
          theme = "dropdown",
          initial_mode = "normal",
        },

        lsp_declarations = {
          theme = "dropdown",
          initial_mode = "normal",
        },

        lsp_implementations = {
          theme = "dropdown",
          initial_mode = "normal",
        },
        oldfiles = {
          initial_mode = "normal",
          cwd_only = true
        },
      },
      extensions = {
        project = {
          order_by = "recent",
          sync_with_nvim_tree = false,
          display_type = "minimal"
        },
        file_browser = {
          initial_mode = "normal",
          theme = "dropdown",
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = true,
          path_display = function(opts, path)
            local tail = require("telescope.utils").path_tail(path)
            return string.format("%s", tail)
          end,
          mappings = {
            ["i"] = {
              -- your custom insert mode mappings
            },
            ["n"] = {
              -- your custom normal mode mappings
            },
          },
        },
        bibtex = {
          -- Depth for the *.bib file
          depth = 10,
          -- Custom format for citation label
          custom_formats = {},
          -- Format to use for citation label.
          -- Try to match the filetype by default, or use 'plain'
          format = '',
          -- Path to global bibliographies (placed outside of the project)
          global_files = {},
          -- Define the search keys to use in the picker
          search_keys = { 'author', 'year', 'title' },
          -- Template for the formatted citation
          citation_format = '{{author}} ({{year}}), {{title}}.',
          -- Only use initials for the authors first name
          citation_trim_firstname = true,
          -- Max number of authors to write in the formatted citation
          -- following authors will be replaced by "et al."
          citation_max_auth = 2,
          -- Context awareness disabled by default
          context = false,
          -- Fallback to global/directory .bib files if context not found
          -- This setting has no effect if context = false
          context_fallback = true,
          -- Wrapping in the preview window is disabled by default
          wrap = false,
        },
      }
    }
  end
}
