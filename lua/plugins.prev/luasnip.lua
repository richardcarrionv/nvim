return {
  "L3MON4D3/LuaSnip",
  config = function()
    local luasnip = require('luasnip')

    luasnip.setup({})

    local my_snippets = '~/.config/nvim/snippets/'

    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_vscode").lazy_load({ paths = { my_snippets } })
    luasnip.filetype_extend("all", { 'loremipsum' })
    luasnip.filetype_extend("javascript", { "javascriptreact" })
    luasnip.filetype_extend("javascript", { "html" })
  end,
  dependencies = {
    "rafamadriz/friendly-snippets",
  }
}
