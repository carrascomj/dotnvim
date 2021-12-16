vim.cmd("set iskeyword+=-") -- treat dash separated words as a word text object"
-- vim.cmd('set shortmess+=c') -- Don't pass messages to |ins-completion-menu|.
-- vim.cmd('set nofoldenable') -- Make substitution work in realtime
vim.cmd("set nohlsearch") -- Don't pollute the screen with yellow (/)
-- vim.cmd('set incsearch') -- Make substitution work in realtime
vim.cmd("set noswapfile")
-- vim.cmd('set smarttab')
vim.go.termguicolors = true -- set term giu colors most terminals support this
vim.o.hidden = O.hidden_files -- Required to keep multiple buffers open multiple buffers
vim.o.updatetime = 300 -- Faster completion
vim.o.timeoutlen = 200 -- By default timeoutlen is 1000 ms
-- vim.o.clipboard = "unnamedplus" -- Copy paste between vim and everything else
vim.wo.number = O.number -- set numbered lines
vim.wo.relativenumber = O.relative_number -- set relative number
vim.cmd("set cindent")
vim.cmd("set tabstop=2")
vim.cmd("set shiftwidth=2")
-- always uses spaces instead of tab characters
vim.bo.expandtab = true -- Converts tabs to spaces
-- for compe
-- vim.o.completeopt = "menu,menuone,noselect"

-- infinite undo history
vim.cmd([[
	set undodir =~/.vim/vimdid
	set undofile
]])

-- vim-test
vim.cmd([[
	let test#strategy = "neovim"
	let test#python#runner = 'pytest'
	let test#python#pytest#executable = 'python -m pytest'
]])

-- csv weird
vim.cmd([[
if exists("did_load_csvfiletype")
  finish
endif
let did_load_csvfiletype=1

augroup filetypedetect
  au! BufRead,BufNewFile *.csv,*.dat	setfiletype csv
augroup END
]])

-- italics for onedark
vim.cmd([[
	let g:onedark_terminal_italics = 1
]])

-- show a line delimiter
vim.cmd("set colorcolumn=80")
vim.cmd("highlight ColorColumn guibg=#313643")
vim.wo.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time

vim.o.title = true
TERMINAL = vim.fn.expand("$TERMINAL")
vim.cmd('let &titleold="' .. TERMINAL .. '"')
vim.o.titlestring = "%<%F%=%l/%L - nvim"
-- vim.wo.wrap = O.wrap_lines -- Display long lines as just one line
vim.cmd("set whichwrap+=<,>,[,],h,l") -- move to next line with theses keys
vim.cmd("syntax on") -- move to next line with theses keys
-- vim.o.pumheight = 10 -- Makes popup menu smaller
vim.o.fileencoding = "utf-8" -- The encoding written to file
vim.o.cmdheight = 2 -- More space for displaying messages
vim.o.mouse = "a" -- Enable your mouse
vim.o.splitbelow = true -- Horizontal splits will automatically be below
vim.o.splitright = true -- Vertical splits will automatically be to the right
vim.go.t_Co = "256" -- Support 256 colors
vim.o.conceallevel = 0 -- So that I can see `` in markdown files
vim.bo.smartindent = true -- Makes indenting smart
vim.wo.cursorline = true -- Enable highlighting of the current line
vim.o.showtabline = 2 -- Always show tabs
vim.o.showmode = false -- We don't need to see things like -- INSERT -- anymore
-- vim.o.backup = false -- This is recommended by coc
-- vim.o.writebackup = false -- This is recommended by coc
-- vim.o.guifont = "JetBrainsMono\\ Nerd\\ Font\\ Mono:h18"
-- vim.o.guifont = "Hack\\ Nerd\\ Font\\ Mono"
-- vim.o.guifont = "SauceCodePro Nerd Font:h17"
vim.o.guifont = "FiraCode Nerd Font:h17"

-- vim.o.guifont = "JetBrains\\ Mono\\ Regular\\ Nerd\\ Font\\ Complete"
-- Complete stuff
vim.opt.completeopt = { "menu", "menuone", "noselect" }
-- Don't show the dumb matching stuff.
vim.opt.shortmess:append("c")
