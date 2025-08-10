return {
	"catppuccin/nvim",
	name = "catppuccin",
	config = function()
		require("catppuccin").setup({
			color_overrides = {
				mocha = {
					base = "#0d0d13", -- editor background (darker)
					mantle = "#12121a", -- panel background (slightly lighter)
					crust = "#12121a", -- optional: matches mantle for borders
				},
			},
		})

		-- setup must be called before loading
		vim.cmd.colorscheme("catppuccin")
	end,
}
