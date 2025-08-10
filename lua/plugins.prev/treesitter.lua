return {
	"nvim-treesitter/nvim-treesitter",
  branch = "main",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			auto_install = true,
			ensure_installed = {
				"lua",
				"javascript",
				"typescript",
				"tsx",
				"markdown",
				"markdown_inline",
				"html",
				"css",
				"json",
				"bash",
				"python",
				"java",
				"php",
				"vim",
				"latex",
				"sql",
				"bash",
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
				disable = {
					"latex",
				},
			},
			indent = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "ms",
					-- NOTE: These are visual mode mappings
					node_incremental = "ms",
					node_decremental = "mS",
					scope_incremental = "mc",
				},
			},
			-- nvim-treesitter/nvim-treesitter-refactor
			refactor = {
				highlight_definitions = { enable = true },
				-- highlight_current_scope = { enable = false },
			},
		})
	end,
}
