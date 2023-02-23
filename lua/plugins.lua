-- Lazy bootstrapping
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

return require("lazy").setup({
		-- Fater plugin loading
		-- use("lewis6991/impatient.nvim")

		-- Color
		{"junegunn/rainbow_parentheses.vim"},
		{ "uga-rosa/ccc.nvim", config = function ()
			vim.opt.termguicolors = true
			require"ccc".setup { highlighter = { auto_enable = true } }
		end, lazy=false},

		-- Lsp
		{"neovim/nvim-lspconfig"},
		{"kabouzeid/nvim-lspinstall"},
		{'nvim-lua/lsp_extensions.nvim'},
		{'github/copilot.vim'},

		-- Unit tests
		{"vim-test/vim-test"},

		-- Telescope
		{"nvim-lua/popup.nvim"},
		{"nvim-lua/plenary.nvim"},
		{"nvim-telescope/telescope.nvim"},
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		-- Harpoon strange choice of the year
		{"ThePrimeagen/harpoon"},

		-- Pop-up for code actions
		{
			"weilbith/nvim-code-action-menu",
			cmd = "CodeActionMenu",
		},

		-- Autocomplete
		{"onsails/lspkind-nvim"},
		{"hrsh7th/nvim-cmp", lazy=true},
		{"hrsh7th/cmp-vsnip", lazy=true},
		{"hrsh7th/vim-vsnip", lazy=true},
		{"rafamadriz/friendly-snippets"},
		{"hrsh7th/cmp-buffer"},
		{"hrsh7th/cmp-path"},
		{"hrsh7th/cmp-nvim-lua"},
		{"hrsh7th/cmp-nvim-lsp"},
		{"windwp/nvim-autopairs"},

		-- Treesitter
		{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate", lazy=false},
		{"nvim-treesitter/nvim-treesitter-textobjects"},
		{"mizlan/iswap.nvim", config=function ()
			require("iswap").setup()
		end},
		-- stan syntax
		{"maedoc/stan.vim"},

		-- colorscheme
		{"navarasu/onedark.nvim", lazy=false},

		{"lewis6991/gitsigns.nvim", version ="v0.5" },
		{"terrortylor/nvim-comment" },

		-- Surround
		{"tpope/vim-surround"},

		-- Status Line
    {"NTBBloodbath/galaxyline.nvim"},
		{"nvim-tree/nvim-web-devicons"},

		-- weird csv stuff
		{"chrisbra/csv.vim"},
		{"jose-elias-alvarez/null-ls.nvim", config=function ()
			require("null-ls").setup({
				debug=true,
				sources = {
					require("null-ls").builtins.diagnostics.write_good.with({filetypes={"markdown", "tex", "text"}}),
					require("null-ls").builtins.formatting.black.with({filetypes={"python"}}),
				}
			})
			end
		},

		{
			'chipsenkbeil/distant.nvim',
			branch = "v0.2",
			config = function()
    		require('distant').setup {
		      -- Applies Chip's personal settings to every machine you connect to
		      --
		      -- 1. Ensures that distant servers terminate with no connections
		      -- 2. Provides navigation bindings for remote directories
		      -- 3. Provides keybinding to jump into a remote file's parent directory
					ssh = { ssh_identity_file = {'/home/georg/.ssh/qmcm01_key.pem' }},
					["*"] = {dir = { mappings = { ['<Return>'] = require('distant.nav.actions').edit } }}
    		}
  		end
		},

		{
			"glepnir/lspsaga.nvim",
			branch = "main",
			config = function()
					local saga = require("lspsaga")
					saga.setup({ui = {
						border ="single",
						colors = {
							normal_bg = "NONE",

							title_bg = "NONE"
				}}})
				end,
			event = "BufRead",
		}
})
