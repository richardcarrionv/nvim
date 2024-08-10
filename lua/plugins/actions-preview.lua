return {
  "aznhe21/actions-preview.nvim",
  config = function()
    vim.keymap.set({ "v", "n" }, "<leader>ca", require("actions-preview").code_actions)
    require("actions-preview").setup {
      -- options for vim.diff(): https://neovim.io/doc/user/lua.html#vim.diff()
      diff = {
        ctxlen = 3,
      },

      -- priority list of external command to highlight diff
      -- disabled by defalt, must be set by yourself
      highlight_command = {
        -- require("actions-preview.highlight").delta(),
        -- require("actions-preview.highlight").diff_so_fancy(),
        -- require("actions-preview.highlight").diff_highlight(),
      },

      -- priority list of preferred backend
      backend = { "telescope" },

      -- options related to telescope.nvim
      telescope = vim.tbl_extend(
        "force",
        -- telescope theme: https://github.com/nvim-telescope/telescope.nvim#themes
        require("telescope.themes").get_cursor(),
        -- a table for customizing content
        {
          initial_mode = "normal",
          previewer = false,
        }
      ),
    }
  end,
}
