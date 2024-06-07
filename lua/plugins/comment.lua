require('Comment').setup({
  pre_hook =
      require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
  ---LHS of operator-pending mappings in NORMAL and VISUAL mode
  opleader = {
    ---Line-comment keymap
    line = '<leader>c<leader>',
    ---Block-comment keymap
    block = '<leader>d<leader>',
  },
  padding = true,
})
