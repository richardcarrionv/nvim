local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local lazy = require('lazy')

lazy.setup({
  require("carri.plugins.init"),
  require("carri.plugins.nvim-tree"),
})


--require("lazy").setup("plugins.nvim-tree")

-- -- Plenary
-- use("nvim-lua/plenary.nvim")
--
-- -- File Explorer
--
-- -- Icons
-- use("kyazdani42/nvim-web-devicons")
--
-- --ColorScheme
-- use({
--   "rebelot/kanagawa.nvim",
--   config = function()
--     require("plugins.kanagawa")
--   end,
-- })
-- use({
--   "rose-pine/neovim",
--   as = "rose-pine",
--   config = function()
--     require("plugins.rose-pine")
--   end,
-- })
-- use({
--   "owickstrom/vim-colors-paramount",
-- })
-- use({ "nyoom-engineering/oxocarbon.nvim" })
-- use({
--   "folke/tokyonight.nvim",
-- })
-- use({ "ellisonleao/gruvbox.nvim" })
--
-- --Treesitter: Syntax-Highlighting
-- use({
--   "nvim-treesitter/nvim-treesitter",
--   event = "CursorHold",
--   run = function()
--     require("nvim-treesitter.install").update({ with_sync = true })
--   end,
--   config = function()
--     require("plugins.treesitter")
--   end,
-- })
--
-- --Language Server Protocol Config
-- use({
--   "neovim/nvim-lspconfig",
--   event = "BufRead",
--   config = function()
--     require("plugins.lsp.lspconfig")
--   end,
--   requires = {
--     { "hrsh7th/cmp-nvim-lsp" },
--   },
-- })
--
-- --Package Manager LSP Servers, DAP Servers, etc...
-- use("williamboman/mason.nvim")
-- use("williamboman/mason-lspconfig.nvim")
--
-- use({
--   "stevearc/conform.nvim",
--   config = function()
--     require("plugins.conform")
--   end,
-- })
--
-- -- Comment
-- use({
--   "numToStr/Comment.nvim",
--   event = "BufRead",
--   config = function()
--     require("plugins.comment")
--   end,
-- })
--
-- --Autocompletion
-- use({
--   {
--     "hrsh7th/nvim-cmp",
--     event = "InsertEnter",
--     config = function()
--       require("plugins.lsp.nvim-cmp")
--     end,
--     requires = {
--       {
--         "L3MON4D3/LuaSnip",
--         event = "CursorHold",
--         config = function()
--           require("plugins.lsp.luasnip")
--         end,
--         requires = {
--           {
--             "rafamadriz/friendly-snippets",
--           },
--         },
--       },
--     },
--   },
--   { "hrsh7th/cmp-path",         after = "nvim-cmp" },
--   { "hrsh7th/cmp-buffer",       after = "nvim-cmp" },
--   { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
--   { "hrsh7th/cmp-cmdline",      after = "nvim-cmp" },
-- })
--
-- -- Telescope
-- use({
--   "nvim-telescope/telescope.nvim",
--   tag = "0.1.2",
--   config = function()
--     require("plugins.telescope")
--   end,
--   requires = { { "nvim-lua/plenary.nvim" } },
-- })
--
-- -- Autotag
-- use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" })
--
-- --Autopairs
-- use({
--   "windwp/nvim-autopairs",
--   config = function()
--     require("plugins.pairs")
--   end,
-- })
--
-- --Gitsigns
-- use({
--   "lewis6991/gitsigns.nvim",
--   config = function()
--     require("plugins.gitsigns")
--   end,
-- })
--
-- --LaTeX support
-- use({
--   "lervag/vimtex",
--   config = function()
--     require("plugins.vimtex")
--   end,
-- })
--
-- -- Java Language Server
-- use({ "mfussenegger/nvim-jdtls" })
--
-- -- Navigation for tmux and neovim
-- use({ "christoomey/vim-tmux-navigator" })
--
-- -- ThePrimeagen Harpoon
-- use({
--   "ThePrimeagen/harpoon",
--   branch = "harpoon2",
--   requires = { { "nvim-lua/plenary.nvim" } },
-- })
--
-- use({ "folke/neodev.nvim" })
--
-- use({
--   "kylechui/nvim-surround",
--   tag = "*", -- Use for stability; omit to use `main` branch for the latest features
--   config = function()
--     require("plugins.surround")
--   end,
-- })
--
-- use({
--   "iamcco/markdown-preview.nvim",
--   run = "cd app && npm install",
--   setup = function()
--     vim.g.mkdp_filetypes = { "markdown" }
--   end,
--   ft = { "markdown" },
-- })
--
-- use({
--   "folke/trouble.nvim",
--   requires = { "nvim-tree/nvim-web-devicons" },
--   config = function()
--     require("plugins.trouble")
--   end,
-- })
--
-- use({
--   "weilbith/nvim-code-action-menu",
--   cmd = "CodeActionMenu",
-- })
--
-- use({ "godlygeek/tabular" })
--
-- use({
--   "nvim-telescope/telescope-bibtex.nvim",
--   requires = {
--     { "nvim-telescope/telescope.nvim" },
--   },
--   config = function()
--     require("telescope").load_extension("bibtex")
--   end,
-- })
--
-- use({
--   "TrevorS/uuid-nvim",
--   lazy = true,
--   config = function()
--     require("plugins.uuid-plugin")
--   end,
-- })
--
-- use("rafcamlet/nvim-luapad")
-- use({
--   "mfussenegger/nvim-dap",
-- })
--
-- use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } })
