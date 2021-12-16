require("nvim-treesitter.configs").setup({
	ensure_installed = "all",
	highlight = {
		enable = true, -- false will disable the whole extension
		custom_captures = {
			["text.title"] = "Question",
			["text.reference"] = "Keyword",
			["text.emphasis"] = "markdownItalic",
			["text.uri"] = "markdownUrl",
		}
	},
	-- indent = {enable = true, disable = {"python", "html", "javascript"}},
	-- TODO seems to be broken
	indent = { disable = { "python" } },
	autotag = { enable = true },
	textobjects = {
		select = {
			enable = true,

			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,

			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["ab"] = "@block.outer",
				["ib"] = "@block.inner",
			},

			-- move to next function!
			goto_next_start = {
        ["]]"] = "@function.outer",
      },
      goto_previous_start = {
        ["[["] = "@function.outer",
      },
		},
	},
})
