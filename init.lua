vim.g.mapleader = ' '


require('plugins')
require('lv-globals')
vim.cmd('luafile ~/.config/nvim/lv-settings.lua')
require('lv-autocommands')
require('settings')
require('colorscheme')
require('keymappings')
require('myline')
require('cmp-me')
require('lv-comment')
require('lv-telescope')
require('lv-gitsigns')
require('lv-autopairs')
require('lv-treesitter')
require('harp')

-- LSP
require('lsp')
require('lsp.lua-ls')
-- require('lsp.efm-general-ls')
-- require('lsp.pylsp')
require('lsp.python-ls')
-- require('lsp.js-ts-ls')
require('lsp.rust-ls')
require('lsp.json-ls')
require('lsp.yaml-ls')
require('lsp.vim-ls')
require('lsp.docker-ls')
require('lsp.latex-ls')
require('lsp.maud-ls')
require('lsp.taplo-ls')
