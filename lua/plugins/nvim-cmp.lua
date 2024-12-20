return {
  "hrsh7th/nvim-cmp",
  config = function()
    local luasnip = require("luasnip")
    local icons = require("plugins.misc.icons")
    local cmp = require("cmp")

    local aliases = {
      nvim_lsp = "LSP",
      luasnip = "Snp",
      buffer = "BR",
      latex_symbols = "LTX Sym",
    }

    local function select_next_item(fallback)
      if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end

    local function select_prev_item(fallback)
      if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end

    local mappings = {

      ["<C-e>"] = cmp.mapping.close(),
      ["<C-o>"] = cmp.mapping.complete(),

      ["<C-u>"] = cmp.mapping.scroll_docs(-4),
      ["<C-d>"] = cmp.mapping.scroll_docs(4),

      ["<Enter>"] = cmp.mapping.confirm({ select = true }),
      ["<C-f>"] = cmp.mapping.confirm({ select = true }),

      -- Select next item
      ["<Tab>"] = cmp.mapping(select_next_item, { "i", "s" }),
      ["<C-j>"] = cmp.mapping(select_next_item, { "i", "s" }),

      -- Select previous item
      ["<S-Tab>"] = cmp.mapping(select_prev_item, { "i", "s" }),
      ["<C-k>"] = cmp.mapping(select_prev_item, { "i", "s" }),

      -- Snippets next
      ["<C-n>"] = cmp.mapping(function()
        if luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        end
      end, { "i", "s" }),
      -- Snippets previous
      ["<C-p>"] = cmp.mapping(function()
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        end
      end, { "i", "s" }),

    }

    cmp.setup({
      enabled = function()
        -- disable completion in comments
        local context = require("cmp.config.context")
        -- keep command mode completion enabled when cursor is in a comment
        if vim.api.nvim_get_mode().mode == "c" then
          vim.cmd("set pumheight=0")
          return true
        else
          vim.cmd("set pumheight=14")
          return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
        end
      end,
      mapping = cmp.mapping.preset.insert(mappings),
      sources = cmp.config.sources({
        { name = "nvim_lsp", max_item_count = 20 },
        { name = "luasnip",  max_item_count = 5 },
        { name = "path",     max_item_count = 3 },
        -- { name = "latex_symbols", max_item_count = 3 },
        -- Annoying
        -- { name = 'nvim_lsp_signature_help' },
      }),
      experimental = {
        ghost_text = true,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      formatting = {
        fields = { "abbr", "kind", "menu" },
        expandable_indicator = false,
        format = function(entry, item)
          -- Kind icons
          item.kind = string.format("%s %s", icons[item.kind], item.kind)
          -- Source
          item.menu = string.format("[%s]", aliases[entry.source.name] or entry.source.name)
          -- item.menu = ''
          return item
        end,
      },
    })

    cmp.setup.filetype({ "sql" }, {
      sources = {
        { name = "vim-dadbod-completion" },
        { name = "buffer" }
      }
    })
  end,
  dependencies = {
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp-signature-help",
  },
}
