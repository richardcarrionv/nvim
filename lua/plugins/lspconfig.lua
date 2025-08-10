return {
	"neovim/nvim-lspconfig",
	config = function()
		vim.lsp.config("ts_ls", {
			init_options = {
				hostInfo = "neovim",
				preferences = {
					providePrefixAndSuffixTextForRename = false,
				},
			},
		})

		local servers = {
			"html",
			"cssls",
			"jsonls",
			-- "pyright",
			"ts_ls",
			"lua_ls",
			-- "texlab",
			-- "tailwindcss",
			"bashls",
			"gradle_ls",
			-- "kotlin_language_server",
			"kotlin_lsp",
			"yamlls",
			-- "gopls"
			-- "nil_ls"
		}
		for _, server in pairs(servers) do
			vim.lsp.enable(server)
		end

		vim.diagnostic.config({
			virtual_text = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.HINT] = "",
					[vim.diagnostic.severity.INFO] = "",
				},
			},
		})
	end,
}
