local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require('cmp')

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local mappings = {
  ['<C-e>'] = cmp.mapping.close(),
  ['<C-k>'] = cmp.mapping.scroll_docs(-4),
  ['<C-j>'] = cmp.mapping.scroll_docs(4),
  ['<Enter>'] = cmp.mapping.confirm({ select = true }),
  ['<C-space>'] = cmp.mapping.complete(),
  ['<C-o>'] = cmp.mapping.complete(),
  ['<C-.>'] = cmp.mapping(function(fallback)
    if luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    else
      fallback()
    end
  end, { "i", "s" }),
  ["<Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif has_words_before() then
      cmp.complete()
    else
      fallback()
    end
  end, { "i", "s" }),
  ["<S-Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    else
      fallback()
    end
  end, { "i", "s" }),
}


local luasnip = require("luasnip")
local icons = require("plugins.misc.cmp.icons")

local icons = icons.icons

local aliases = {
  nvim_lsp = 'LSP',
  luasnip = 'Snp',
  buffer = "BR",
  latex_symbols = "LTX Sym"
}

cmp.setup({
  mapping = cmp.mapping.preset.insert(mappings),
  sources = cmp.config.sources({
    { name = 'nvim_lsp',      max_item_count = 5 },
    { name = 'luasnip',       max_item_count = 1 },
    { name = 'path',          max_item_count = 3 },
    { name = 'latex_symbols', max_item_count = 3 },
  }),
  experimental = {
    ghost_text = true,
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  formatting = {
    format = function(entry, item)
      -- Kind icons
      item.kind = string.format('%s %s', icons[item.kind], item.kind)
      -- Source
      -- item.menu = string.format('[%s]', aliases[entry.source.name] or entry.source.name)
      item.menu = ''
      return item
    end,
  },
})
