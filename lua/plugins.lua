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
  use('rebelot/kanagawa.nvim')

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
  use { 'ibhagwan/fzf-lua',
    requires = { 'nvim-tree/nvim-web-devicons' }
  }


  if packer_bootstrap then
    require('packer').sync()
  end
end)
