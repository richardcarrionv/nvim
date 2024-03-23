--vim.loader.enable()

local g = vim.g
local o = vim.o

-- vim.cmd([[ autocmd VimEnter * hi NonText guifg=bg]])

vim.cmd([[ autocmd VimEnter * highlight EndOfBuffer guifg=black guifg=black]])
vim.cmd([[ autocmd VimEnter * nnoremap <silent> J :let p=getpos('.')<bar>join<bar>call setpos('.', p)<cr>]])

-- vim.cmd([[ autocmd VimEnter * hi WinSeparator guifg=#727169 ]])
--vim.cmd([[ autocmd BufReadPre *.tex setlocal textwidth=80]])
-- vim.cmd([[ autocmd ColorScheme * highlight highlight NvimTreeBg guibg=#2B4252 ]])
-- vim.cmd([[ autocmd FileType NvimTree setlocal winhighlight=Normal:NvimTreeBg ]])
-- Hide statusline by setting laststatus and cmdheight to 0.
--o.ls = 0
--o.ch = 0

-- Set the winbar to the statusline.
--o.wbr = "%f"
vim.opt.laststatus = 2 -- Or 3 for global statusline
vim.opt.statusline = "%F %m %= %l:%c / %L"
-- vim.opt.guitablabel = "%f"
-- With vertical splits, the statusline would still show up at the
-- bottom of the split. A quick fix is to just set the statusline
-- to empty whitespace (it can't be an empty string because then
-- it'll get replaced by the default stline).
--o.stl = " "

--vim.cmd([[syntax enable]])
--vim.api.nvim_command('filetype plugin indent on')
g.loaded = 1
g.loaded_netrwPlugin = 1

o.termguicolors = true

o.hls = true

o.background = "dark"

-- Do not save when switching buffers
o.hidden = true

-- Decrease update time
o.timeoutlen = 500
o.updatetime = 200

-- Number of screen lines to keep above and below the cursor
-- o.scrolloff = 8

-- Better editor UI
o.number = true
o.relativenumber = true
--o.numberwidth = 5
o.signcolumn = "auto"
--o.cursorline = true

-- Better editing experience
o.expandtab = true
o.smarttab = true
o.cindent = true

o.autoindent = true
o.wrap = false
o.textwidth = 300
o.tabstop = 2
o.shiftwidth = 0
o.softtabstop = -1 -- If negative, shiftwidth value is used

o.list = false
o.listchars = "trail:·,nbsp:◇,tab:→,,extends:▸,precedes:◂"
-- o.listchars = 'eol:¬,space:·,lead: ,trail:·,nbsp:◇,tab:→-,extends:▸,precedes:◂,multispace:···⬝,leadmultispace:│   ,'
-- o.formatoptions = 'qrn1'

-- Makes neovim and host OS clipboard play nicely with each other
o.clipboard = "unnamedplus"

-- Case insensitive searching UNLESS /C or capital in search
o.ignorecase = true
o.smartcase = true

-- Undo and backup options
o.backup = false
o.writebackup = false
o.undofile = true
o.swapfile = false
-- o.backupdir = '/tmp/'
-- o.directory = '/tmp/'
-- o.undodir = '/tmp/'

-- Remember 50 items in commandline history
o.history = 50

-- Better buffer splitting
o.splitright = true
o.splitbelow = true

-- Preserve view while jumping
o.jumpoptions = "view"

-- BUG: this won't update the search count after pressing `n` or `N`
-- When running macros and regexes on a large file, lazy redraw tells neovim/vim not to draw the screen
-- o.lazyredraw = true

-- Better folds (don't fold by default)
-- o.foldmethod = 'indent'
-- o.foldlevelstart = 99
-- o.foldnestmax = 3
-- o.foldminlines = 1

-- Map <leader> to space
g.mapleader = " "
g.maplocalleader = " "
