require('nvim-treesitter.install').compilers = { "zig" }
require('nvim-treesitter.configs').setup({
  auto_install = true,
  ensure_installed = {
    'lua',
    'javascript',
    'typescript',
    'tsx',
    'markdown',
    'markdown_inline',
    'html',
    'css',
    'json',
    'bash',
    'python',
    'java',
    'php',
    'vim',
    'latex',
    'sql',
    'bash',
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    disable = {
      "latex"
    },
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gs',
      -- NOTE: These are visual mode mappings
      node_incremental = 'gs',
      node_decremental = 'gS',
      scope_incremental = '<leader>gc',
    },
  },
  -- nvim-treesitter/nvim-treesitter-textobjects
  textobjects = {
  },
  -- windwp/nvim-ts-autotag
  autotag = {
    enable = true,
  },
  -- nvim-treesitter/nvim-treesitter-refactor
  refactor = {
    highlight_definitions = { enable = true },
    -- highlight_current_scope = { enable = false },
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
})
