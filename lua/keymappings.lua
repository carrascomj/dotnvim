vim.api.nvim_set_keymap("n", "<Space>", "<NOP>", { noremap = true, silent = true })

-- better window movement
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { silent = true })

-- TODO fix this
vim.cmd([[
  noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
  noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
  noremap <C-J> a<CR><Esc>k$
	noremap <C-q> :lua require('lv-telescope').fdsbml()<CR>
	nnoremap <C-n> :lua require('lv-telescope').bib()<CR>
	nnoremap <C-b> :lua require('lv-telescope').search_dotfiles()<CR>

	vnoremap <C-y> "*y :let @+=@*<CR>
  map <C-p> "+P
	let mapleader = " "
]])

-- telescope
vim.keymap.set(
	"",
	"<leader>f",
	function ()
		require("telescope.builtin").find_files({find_command = { "fd", "--type", "f", "--search-path", ".", "--search-path", ".github"}})
	end,
	{ noremap = false, silent = true }
)
vim.api.nvim_set_keymap("", "<leader>g", [[:Telescope grep_string<CR>]], { noremap = false })
vim.api.nvim_set_keymap("n", "gr", ":Telescope lsp_references<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>F", ":lua require'telescope.builtin'.find_files({cwd=require'telescope.utils'.buffer_dir()})<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-f>", [[<Cmd>lua vim.lsp.buf.format{ async=True }<CR>]], { noremap = false, silent = true })
vim.api.nvim_set_keymap("n", "<leader>q", ":CodeActionMenu<CR>", { noremap = true, silent = false })
-- test suite, quit terminal (C-\ C-w) and come back to editing window (C-w w)
vim.api.nvim_set_keymap("n", "<leader>s", [[:TestSuite<CR><C-\><C-n><C-w>w]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>a", [[:TestFile<CR><C-\><C-n><C-w>w]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>x", [[<C-w>w:bd!<CR>]], { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "<leader>n", [[:ISwapWith<CR>]], { noremap = true, silent = false })
-- run cargo in vte
vim.api.nvim_set_keymap("n", "<leader>r", [[:vs term://cargo r<CR><C-w>w]], { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "<leader>b", [[:vs term://cargo b<CR><C-w>w]], { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "<leader>c", [[:vs term://cargo clippy<CR><C-w>w]], { noremap = true, silent = false })

-- harpoon: clear list and mark current file
vim.keymap.set(
	"n",
	"<leader>m",
	function()
		require'harpoon.mark'.clear_all() require'harpoon.mark'.add_file()
		print "Harpoon Mark!"
	end,
	{ noremap = false, silent = false }
)

-- better indenting
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true, silent = true })

-- I hate escape
vim.api.nvim_set_keymap("i", "jk", "<ESC>", { noremap = true, silent = true })

-- Tab switch buffer
vim.api.nvim_set_keymap("n", "<TAB>", ":bnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-TAB>", ":bprevious<CR>", { noremap = true, silent = true })

-- Move selected line / block of text in visual mode
vim.api.nvim_set_keymap("x", "K", ":move '<-2<CR>gv-gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "J", ":move '>+1<CR>gv-gv", { noremap = true, silent = true })

-- Format
vim.api.nvim_set_keymap("n", "!", ':w! | !compile.sh "<c-r>%"<CR><CR>', { noremap = true, silent = true })

-- Better nav for omnicomplete
vim.cmd('inoremap <expr> <c-j> ("\\<C-n>")')
vim.cmd('inoremap <expr> <c-k> ("\\<C-p>")')

-- vim.api.nvim_set_keymap("x", "<leader>r", [[:<C-u>MagmaEvaluateVisual<CR>]], { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>ro", [[:MagmaShowOutput<CR>]], { noremap = true, silent = true })

-- Distant
vim.api.nvim_set_keymap("n", "<leader>v", ":DistantConnect ssh://jorge@10.75.0.72 <CR>:DistantOpen /home/jorge/", { noremap=true, silent=false})
vim.api.nvim_set_keymap("n", "<leader>æ", ":DistantConnect ssh://jorge@10.75.3.55 <CR>:DistantOpen /home/jorge/", { noremap=true, silent=false})
vim.api.nvim_set_keymap("n", "<leader>ø", ":DistantConnect ssh://jcamu@10.66.11.49 <CR>:DistantOpen /home/jcamu/", { noremap=true, silent=false})
