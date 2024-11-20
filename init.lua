require("config.settings")
require("config.mappings")
require("config.lazy")

-- Store the starting directory in a global variable
if vim.g.starting_dir == nil then
  vim.g.starting_dir = vim.fn.getcwd()
end

print("Neovim started in directory: " .. vim.g.starting_dir)

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    require("lazy").update({ show = false })
    print("Lazy updated!")
  end,
})
