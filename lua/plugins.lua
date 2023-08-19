local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()


local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end



--Have packer use a popup window
packer.init {
  max_jobs = 50,
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
    prompt_border = "rounded", -- Border style of prompt popups.
  },
}

return require('packer').startup(function(use)
  -- Packer itself
  use('wbthomason/packer.nvim')

  -- Plenary
  use('nvim-lua/plenary.nvim')

  -- File Explorer
  use({
    'kyazdani42/nvim-tree.lua',
    config = function()
      require('plugins.nvim-tree')
    end
  })

  -- Icons
  use('kyazdani42/nvim-web-devicons')

  --ColorScheme
  use({
    'rebelot/kanagawa.nvim',
    config = function()
      require('plugins.kanagawa')
    end
  })
  use({
    'rose-pine/neovim',
    as = "rose-pine",
    config = function()
      require('plugins.rose-pine')
    end
  })
  use({
    "owickstrom/vim-colors-paramount"
  })
  use({ 'nyoom-engineering/oxocarbon.nvim' })
  use({
    "folke/tokyonight.nvim",
  })

  --Treesitter: Syntax-Highlighting
  use({
    'nvim-treesitter/nvim-treesitter',
    event = 'CursorHold',
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
    config = function()
      require('plugins.treesitter')
    end
  })

  --Language Server Protocol Config
  use({
    'neovim/nvim-lspconfig',
    event = 'BufRead',
    config = function()
      require('plugins.lsp.lspconfig')
    end,
    requires = {
      { 'hrsh7th/cmp-nvim-lsp' },
    }
  })

  --Package Manager LSP Servers, DAP Servers, etc...
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")

  --Null-ls
  use({
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require('plugins.null-ls')
    end,
    requires = "nvim-lua/plenary.nvim",
  })

  -- Comment
  use({
    'numToStr/Comment.nvim',
    event = 'BufRead',
    config = function()
      require('plugins.comment')
    end,
  })

  --Autocompletion
  use({ {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    config = function()
      require('plugins.lsp.nvim-cmp')
    end,
    requires = {
      {
        'L3MON4D3/LuaSnip',
        event = 'CursorHold',
        config = function()
          require('plugins.lsp.luasnip')
        end,
        requires = {
          {
            "rafamadriz/friendly-snippets",
          },
        }
      }
    },
  },
    { 'hrsh7th/cmp-path',         after = 'nvim-cmp' },
    { 'hrsh7th/cmp-buffer',       after = 'nvim-cmp' },
    { 'saadparwaiz1/cmp_luasnip', after = "nvim-cmp" },
    { 'hrsh7th/cmp-cmdline',      after = 'nvim-cmp' },
  })

  --Fuzzy finder
  -- use { 'ibhagwan/fzf-lua',
  --   config = function()
  --     require('plugins.fzf-lua')
  --   end,
  --   requires = { 'nvim-tree/nvim-web-devicons' }
  -- }

  -- Telescope
  use({
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    event = 'CursorHold',
    cmd = 'Telescope',
    config = function()
      require('plugins.telescope')
    end,
    requires = { { 'nvim-lua/plenary.nvim' } },

  })

  use({
    "nvim-telescope/telescope-file-browser.nvim",
    requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  })


  -- Autotag
  use({ 'windwp/nvim-ts-autotag', after = 'nvim-treesitter' })


  --Autopairs
  use({
    'windwp/nvim-autopairs',
    config = function()
      require('plugins.pairs')
    end,
  })

  --Gitsigns
  use({
    'lewis6991/gitsigns.nvim',
    config = function()
      require('plugins.gitsigns')
    end
  })

  --LaTeX support
  use({
    'lervag/vimtex',
    config = function()
      require('plugins.vimtex')
    end
  })

  -- Copy paste registers
  use({
    "AckslD/nvim-neoclip.lua",
    config = function()
      require('plugins.neoclip')
    end,
  })

  -- Java Language Server
  use({ 'mfussenegger/nvim-jdtls' })

  -- Navigation for tmux and neovim
  use({ 'christoomey/vim-tmux-navigator' })

  -- ThePrimeagen Harpoon
  use({
    'ThePrimeagen/harpoon',
    requires = {
      { 'nvim-lua/plenary.nvim' },
    }
  })

  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require('plugins.surround')
    end
  })

  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
  })

  use({
    "folke/trouble.nvim",
    requires = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require('plugins.trouble')
    end
  })

  use({
    'weilbith/nvim-code-action-menu',
    cmd = 'CodeActionMenu',
  })

  use({
    "ThePrimeagen/refactoring.nvim",
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" }
    },
    config = function ()
      require('plugins.refactoring')
    end
  })

  if packer_bootstrap then
    require('packer').sync()
  end
end)
