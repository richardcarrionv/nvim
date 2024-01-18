local uuid = require('uuid-nvim')
uuid.setup {
  case = 'lower',
  quotes = 'single',
}

vim.keymap.set('n', '<leader>ut', uuid.insert_v4)
vim.keymap.set('i', '<C-u>', uuid.insert_v4)



