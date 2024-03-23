## Neovim Configuration

### Dependecies

- C compiler: zig, gcc-c++, clang (LLVM)
- Python
  - pip
  - black
- NodeJS
  - npm
  - eslint
  - prettier
    - prettier-plugin-tailwindcss
- ripgrep and fd
- LaTeX
  - Fedora: texlive-scheme-full

### Additional Dependencies for Windows

- WinRar
- wget
- pwsh

### Install dependencies with install.sh

Running install.sh will install the dependecies

### Install neovim plugins steps

1. Install [packer.nvim](https://github.com/wbthomason/packer.nvim#quickstart)
2. Run `PackerInstall`
3. Run `PackerCompile`

## Plugins List

| N.  | Name              | Link                                    |
| --- | ----------------- | --------------------------------------- |
| 1   | packer.nvim       | `wbthomason/packer.nvim`                |
| 2   | plenary.nvim      | `nvim-lua/plenary.nvim`                 |
| 3   | nvimtree          | `kyazdani42/nvim-tree.lua`              |
| 4   | nvim-web-devicons | `kyazdani42/nvim-web-devicons`          |
| 5   | lualine           | `nvim-lualine/lualine.nvim`             |
| 6   | telescope         | `nvim-telescope/telescope.nvim`         |
| 7   | telescope-project | `nvim-telescope/telescope-project.nvim` |
| 8   | treesitter        | `nvim-treesitter/nvim-treesitter`       |
| 9   | autotag           | `windwp/nvim-ts-autotag`                |
| 10  | nvim-lsconfig     | `neovim/nvim-lspconfig`                 |
| 11  | Mason             | `williamboman/mason.nvim`               |
| 12  | MasonLSPConfig    | `williamboman/mason-lspconfig.nvim`     |
| 13  | lsp_signature     | `ray-x/lsp_signature.nvim` j            |
| 14  | nvim-cmp          | `hrsh7th/nvim-cmp`                      |
| 15  | autopairs         | `windwp/nvim-autopairs`                 |
| 16  | neodev            | `folke/neodev.nvim`                     |
| 17  | bufferline        | `akinsho/bufferline.nvim`               |
| 18  | wich-key          | `folke/which-key.nvim`                  |
| 19  | comment.nvim      | `numToStr/Comment.nvim`                 |
| 20  | nvim-surround     | `kylechui/nvim-surround`                |
| 21  | notify            | `rcarriga/nvim-notify`                  |
| 22  | startuptime       | `dstein64/vim-startuptime`              |
| 23  | impatient         | `lewis6991/impatient.nvim`              |
| 24  | goto-preview      | `rmagatti/goto-preview`                 |
| 25  | null-ls           | `jose-elias-alvarez/null-ls.nvim`       |
| 26  | neorg             | `nvim-neorg/neorg`                      |
| 27  | vimtex            | `lervag/vimtex`                         |
| 28  | gitsigns          | `lewis6991/gitsigns.nvim`               |
| 29  | markdown-preview  | `iamcco/markdown-preview.nvim`          |
| 30  | friendly-snippets | `rafamadriz/friendly-snippets`          |
| 31  | trouble           | `folke/trouble.nvim`                    |
| 32  | lspsaga           | `glepnir/lspsaga.nvim`                  |

## ColorScheme

Tokyonight `folke/tokyonight.nvim`

## Ensure Installed LSP Servers

| N.  | Name           | Language               |
| --- | -------------- | ---------------------- |
| 1   | `html`         | HTML                   |
| 2   | `cssls`        | CSS                    |
| 3   | `jsonls`       | JSON                   |
| 4   | `jdtls`        | Java                   |
| 5   | `intelephense` | PHP                    |
| 6   | `sqlls`        | SQL                    |
| 7   | `yamlls`       | YAML                   |
| 8   | `angularls`    | Angular                |
| 9   | `pyright`      | Python                 |
| 10  | `tsserver`     | TypeScript, JavaScript |
| 11  | `lua_ls`       | Lua                    |
| 12  | `texlab`       | LaTeX                  |
