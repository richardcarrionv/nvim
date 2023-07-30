require('luasnip').setup({})

local fn = vim.fn
local friendly_snippets = fn.stdpath('data') .. '/site/pack/packer/start/friendly-snippets'
local my_snippets = '~/.config/nvim/snippets/'

--.local/share/nvim/site/pack/packer/start/friendly-snippets/snippets/
require("luasnip/loaders/from_vscode").load({ paths = {friendly_snippets, my_snippets} })

require('luasnip').filetype_extend("javascript", { "javascriptreact" })
require('luasnip').filetype_extend("javascript", { "html" })
