-- Plugins with Packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup({
	function(use)
		-- Fater plugin loading
		-- use("lewis6991/impatient.nvim")

		-- Color
		use("junegunn/rainbow_parentheses.vim")
		use{ "uga-rosa/ccc.nvim", config = function ()
			vim.opt.termguicolors = true
			require"ccc".setup { highlighter = { auto_enable = true } }
		end }
		-- use("norcalli/nvim-colorizer.lua")

		-- Packer can manage itself as an optional plugin
		use("wbthomason/packer.nvim")

		-- Lsp
		use "neovim/nvim-lspconfig"
		use "kabouzeid/nvim-lspinstall"
		use 'nvim-lua/lsp_extensions.nvim'

		-- Unit tests
		use("vim-test/vim-test")

		-- Telescope
		use "nvim-lua/popup.nvim"
		use "nvim-lua/plenary.nvim"
		use "nvim-telescope/telescope.nvim"
		use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
		-- Harpoon strange choice of the year
		use("ThePrimeagen/harpoon")

		-- Pop-up for code actions
		use({
			"weilbith/nvim-code-action-menu",
			cmd = "CodeActionMenu",
		})

		-- Autocomplete
		use("onsails/lspkind-nvim")
		use("hrsh7th/nvim-cmp")
		use("hrsh7th/cmp-vsnip")
		use("hrsh7th/vim-vsnip")
		use("rafamadriz/friendly-snippets")
		use("hrsh7th/cmp-buffer")
		use("hrsh7th/cmp-path")
		use("hrsh7th/cmp-nvim-lua")
		use("hrsh7th/cmp-nvim-lsp")
		use("windwp/nvim-autopairs")

		-- Treesitter
		use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
		use("nvim-treesitter/nvim-treesitter-textobjects")
		use "nvim-treesitter/nvim-treesitter-refactor"
		use {"mizlan/iswap.nvim", config=function ()
			require("iswap").setup()
		end}
    use "talbergs/context.nvim"
		-- use "nvim-treesitter/playground"
		-- stan syntax
		use "maedoc/stan.vim"

		-- colorscheme
		use "navarasu/onedark.nvim"

		use { "lewis6991/gitsigns.nvim", tag ="v0.5" }
		use({ "terrortylor/nvim-comment" })

		-- Surround
		use("tpope/vim-surround")

		-- Status Line
    use "NTBBloodbath/galaxyline.nvim"
		use "nvim-tree/nvim-web-devicons"

		-- weird csv stuff
		use("chrisbra/csv.vim")
		use{"jose-elias-alvarez/null-ls.nvim", config=function ()
			require("null-ls").setup({
				debug=true,
				sources = {
					require("null-ls").builtins.diagnostics.write_good,
				}
			})
			end
		}

		use {
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
		}

		use({
			"glepnir/lspsaga.nvim",
			branch = "main",
			config = function()
					local saga = require("lspsaga")
					saga.init_lsp_saga()
			end,
		})
  	if packer_bootstrap then
    	require('packer').sync()
  	end
	end,
	compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
})
