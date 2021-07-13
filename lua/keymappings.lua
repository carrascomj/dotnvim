vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', {noremap = true, silent = true})

-- better window movement
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {silent = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {silent = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {silent = true})

-- TODO fix this
vim.cmd([[
  noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
  noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
  noremap <C-J> a<CR><Esc>k$
	noremap <C-q> :lua require('lv-telescope').fdsbml()<CR>
	nnoremap <C-n> :lua require('lv-telescope').bib()<CR>

	vnoremap <C-y> "*y :let @+=@*<CR>
  map <C-p> "+P
]])

-- telescope
vim.api.nvim_set_keymap('', '<C-f>', ':Telescope fd<CR>', {noremap = false})
vim.api.nvim_set_keymap('', '<C-g>', [[:lua require'telescope.builtin'.live_grep({prompt_prefix="﫿"})<CR>]], {noremap = false})
vim.api.nvim_set_keymap('', 'Ñ', [[<Cmd>lua vim.lsp.buf.formatting()<CR>]], {noremap = false, silent=true})

-- harpoon: clear list and mark current file
vim.api.nvim_set_keymap('n', 'Ç', [[:lua require'harpoon.mark'.clear_all() require'harpoon.mark'.add_file()<CR>]], {noremap=false, silent=false})

-- better indenting
vim.api.nvim_set_keymap('v', '<', '<gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '>', '>gv', {noremap = true, silent = true})

-- I hate escape
vim.api.nvim_set_keymap('i', 'jk', '<ESC>', {noremap = true, silent = true})

-- Tab switch buffer
vim.api.nvim_set_keymap('n', '<TAB>', ':bnext<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<S-TAB>', ':bprevious<CR>', {noremap = true, silent = true})

-- Move selected line / block of text in visual mode
vim.api.nvim_set_keymap('x', 'K', ':move \'<-2<CR>gv-gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('x', 'J', ':move \'>+1<CR>gv-gv', {noremap = true, silent = true})

-- Format
vim.api.nvim_set_keymap('', "¡", ':w! | !compiler "<c-r>%"<CR>', {noremap = true, silent = true})

-- Better nav for omnicomplete
vim.cmd('inoremap <expr> <c-j> (\"\\<C-n>\")')
vim.cmd('inoremap <expr> <c-k> (\"\\<C-p>\")')
