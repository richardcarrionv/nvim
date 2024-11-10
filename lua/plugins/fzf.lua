return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- calling `setup` is optional for customization
    local fzf_lua = require("fzf-lua")
    fzf_lua.setup({})


    vim.keymap.set("n", "<leader>fd", function() fzf_lua.files() end)
    vim.keymap.set("n", "<leader>od", function() fzf_lua.oldfiles() end)
    vim.keymap.set("n", "<leader>ep", function() fzf_lua.live_grep() end)
  end
}
