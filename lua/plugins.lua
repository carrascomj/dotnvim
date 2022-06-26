local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
	execute("packadd packer.nvim")
end

--- Check if a file or directory exists in this path
local function require_plugin(plugin)
	local plugin_prefix = fn.stdpath("data") .. "/site/pack/packer/opt/"

	local plugin_path = plugin_prefix .. plugin .. "/"
	--	print('test '..plugin_path)
	local ok, err, code = os.rename(plugin_path, plugin_path)
	if not ok then
		if code == 13 then
			-- Permission denied, but it exists
			return true
		end
	end
	--	print(ok, err, code)
	if ok then
		vim.cmd("packadd " .. plugin)
	end
	return ok, err, code
end

vim.cmd("autocmd BufWritePost plugins.lua PackerCompile") -- Auto compile when there are changes in plugins.lua

return require("packer").startup({
	function(use)
		-- Fater plugin loading
		use("lewis6991/impatient.nvim")

		-- Color
		use("junegunn/rainbow_parentheses.vim")
		use("norcalli/nvim-colorizer.lua")

		-- Packer can manage itself as an optional plugin
		use("wbthomason/packer.nvim")

		-- Lsp
		use({ "neovim/nvim-lspconfig", opt = true })
		use({ "kabouzeid/nvim-lspinstall", opt = true })
		use 'nvim-lua/lsp_extensions.nvim'

		-- unit tests
		use("vim-test/vim-test")

		-- Telescope
		use({ "nvim-lua/popup.nvim", opt = true })
		use({ "nvim-lua/plenary.nvim", opt = true })
		use({ "nvim-telescope/telescope.nvim", opt = true })
		use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
		-- Harpoon strange choice of the year
		use("ThePrimeagen/harpoon")

		-- Pop-up for code actions
		use({
			"weilbith/nvim-code-action-menu",
			cmd = "CodeActionMenu",
		})
		use("kosayoda/nvim-lightbulb")

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

		-- Teesitter
		use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
		use("nvim-treesitter/nvim-treesitter-textobjects")
		use "nvim-treesitter/nvim-treesitter-refactor"
		use "RRethy/nvim-treesitter-textsubjects"
		-- use("nvim-treesitter/nvim-tree-docs")
		-- use "nvim-treesitter/playground"
		-- stan syntax
		use "maedoc/stan.vim"

		-- colorscheme
		use("joshdick/onedark.vim")

		use({ "lewis6991/gitsigns.nvim", opt = true })
		use({ "terrortylor/nvim-comment", opt = true })

		-- Surround
		use("tpope/vim-surround")
		use { 'dccsillag/magma-nvim', run = ':UpdateRemotePlugins' }

		-- Status Line and Bufferline
		-- use{"dsych/galaxyline.nvim", commit="586ed3b6c8f0e066606f6b621b0b34bdb1c9fe57", branch="bugfix/diagnostics"}
    use "NTBBloodbath/galaxyline.nvim"
		-- use("romgrk/barbar.nvim")
		use({ "kyazdani42/nvim-web-devicons", opt = true })

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

		-- SSH: like ratom but more neo and more vim
		use {
			'chipsenkbeil/distant.nvim',
			config = function()
				require('distant').setup {
					-- Applies Chip's personal settings to every machine you connect to
					--
					-- 1. Ensures that distant servers terminate with no connections
					-- 2. Provides navigation bindings for remote directories
					-- 3. Provides keybinding to jump into a remote file's parent directory
					require('distant').setup {
							['*'] = vim.tbl_deep_extend('force', require('distant.settings').chip_default(), {
									mode = 'ssh',
									ssh = {
										identity_files = { '/home/georg/.ssh/qmcm01_key.pem' },
									}
							})
					}
				}
			end
		}

		require_plugin("nvim-lspconfig")
		require_plugin("nvim-lspinstall")
		require_plugin("popup.nvim")
		require_plugin("plenary.nvim")
		require_plugin("telescope.nvim")
		require_plugin("nvim-dap")
		-- require_plugin("nvim-compe")
		-- require_plugin("vim-vsnip")
		require_plugin("nvim-autopairs")
		require_plugin("nvim-treesitter")
		require_plugin("nvim-web-devicons")
		require_plugin("gitsigns.nvim")
		require_plugin("nvim-comment")
		-- require_plugin("nvim-bqf")
		require_plugin("galaxyline.nvim")
		-- require_plugin("barbar.nvim")
	end,
	compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
})
