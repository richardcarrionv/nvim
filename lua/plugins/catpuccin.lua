return {
	"catppuccin/nvim",
	name = "catppuccin",
	config = function()
		require("catppuccin").setup({
			color_overrides = {
				mocha = {
					-- mantle = "#12121a",
					base = "#12121C",
					crust = "#2a283e", -- deeper purple for borders
				},
			},
		})

		-- setup must be called before loading
		vim.cmd.colorscheme("catppuccin")
	end,
}
