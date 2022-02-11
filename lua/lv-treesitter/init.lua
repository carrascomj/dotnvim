require("nvim-treesitter.configs").setup({
	ensure_installed = "all",
	highlight = {
		enable = true, -- false will disable the whole extension
		custom_captures = {
			["text.title"] = "Question",
			["text.reference"] = "Keyword",
			["text.emphasis"] = "markdownItalic",
			["text.uri"] = "markdownUrl",
			["punctuation.special"] = "Keyword",
			["string.escape"] = "Question",
		}
	},
	-- indent = {enable = true, disable = {"python", "html", "javascript"}},
	-- TODO seems to be broken
	indent = { disable = { "python" } },
	autotag = { enable = true },
	-- nvim-treesitter-textobjects motions
	textobjects = {
		select = {
			enable = true,

			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,

			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["ab"] = "@block.outer",
				["ib"] = "@block.inner",
			},

		},
		move = {
			set_jumps = false,
			-- move to next function!
			goto_next_start = {
        ["]]"] = "@function.outer",
      },
      goto_previous_start = {
        ["[["] = "@function.outer",
      },
		}
	},
	refactor = {
		highlight_definitions = { enable = true },
		smart_rename = {
			enable = true,
			keymaps = {
				smart_rename = "gn",
			},
		},
	},
	textsubjects = {
        enable = true,
        prev_selection = ',', -- (Optional) keymap to select the previous selection
        keymaps = {
            ['if'] = 'textsubjects-container-outer',
            ['af'] = 'textsubjects-container-inner',
        },
    }
	-- add treesitter-powered docs
	-- tree_docs = {
	-- 	enable = true,
	-- 	keymaps = {
	-- 		doc_node_at_cursor = "<leader>d"
	-- 	}
	-- }
})
