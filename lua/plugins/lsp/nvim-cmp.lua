local luasnip = require("luasnip")
local icons = require("plugins.misc.cmp.icons")

local icons = icons.icons

local aliases = {
	nvim_lsp = "LSP",
	luasnip = "Snp",
	buffer = "BR",
	latex_symbols = "LTX Sym",
}

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require("cmp")

local mappings = {
	["<C-e>"] = cmp.mapping.close(),
	["<C-k>"] = cmp.mapping.scroll_docs(-4),
	["<C-j>"] = cmp.mapping.scroll_docs(4),
	["<Enter>"] = cmp.mapping.confirm({ select = true }),
	["<C-space>"] = cmp.mapping.complete(),
	["<C-o>"] = cmp.mapping.complete(),
	["<Tab>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_next_item()
		else
			fallback()
		end
	end, { "i", "s" }),
	["<C-n>"] = cmp.mapping(function(fallback)
		if luasnip.expand_or_locally_jumpable() then
			luasnip.expand_or_jump()
		end
	end, { "i", "s" }),
	["<C-p>"] = cmp.mapping(function(fallback)
		if luasnip.jumpable(-1) then
			luasnip.jump(-1)
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

cmp.setup({
	enabled = function()
		-- disable completion in comments
		local context = require("cmp.config.context")
		local buftype = vim.api.nvim_buf_get_option(0, "buftype")
		-- keep command mode completion enabled when cursor is in a comment
		if buftype == "prompt" then
			return false
		end
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
		{ name = "nvim_lsp", max_item_count = 50 },
		{ name = "luasnip", max_item_count = 5 },
		{ name = "path", max_item_count = 3 },
		{ name = "latex_symbols", max_item_count = 3 },
	}),
	experimental = {
		ghost_text = true,
	},
	window = {
		completion = cmp.config.window.bordered(),
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	formatting = {
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
