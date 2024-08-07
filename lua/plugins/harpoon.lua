return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")

    -- REQUIRED
    harpoon:setup()
    -- REQUIRED

    -- vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
    --
    vim.keymap.set("n", "<leader>aa", function() harpoon:list():append() end)
    vim.keymap.set("n", "<leader>aj", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<leader>ak", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<leader>al", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<leader>a;", function() harpoon:list():select(4) end)
    vim.keymap.set("n", "<leader>.", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
    --
    -- -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<leader>ap", function() harpoon:list():prev() end)
    vim.keymap.set("n", "<leader>an", function() harpoon:list():next() end)
  end

}
