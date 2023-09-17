require("nvim-treesitter.configs").setup({
	ensure_installed = {"python", "rust", "c", "cpp", "lua", "toml", "markdown", "latex", "rst", "html", "javascript", "bibtex", "css", "markdown_inline", "hypr"},
	highlight = { enable = true, -- false will disable the whole extension
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
				["af"] = "@function.outer",
				["if"] = "@function.inner",
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
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.hypr = {
  install_info = {
    url = "https://github.com/luckasRanarison/tree-sitter-hypr",
    files = { "src/parser.c" },
    branch = "master",
  },
  filetype = "hypr",
}

-- recover rst python docs
-- from https://github.com/nvim-treesitter/nvim-treesitter/pull/2168 
require("vim.treesitter.query").set("python", "injections", [[
((call
  function: (attribute
	  object: (identifier) @_re)
  arguments: (argument_list (string) @regex))
 (#eq? @_re "re")
 (#lua-match? @regex "^r.*"))
; Module docstring
((module . (expression_statement (string) @rst))
 (#offset! @rst 0 3 0 -3))
; Class docstring
((class_definition
  body: (block . (expression_statement (string) @rst)))
 (#offset! @rst 0 3 0 -3))
; Function/method docstring
((function_definition
  body: (block . (expression_statement (string) @rst)))
 (#offset! @rst 0 3 0 -3))
; Attribute docstring
(((expression_statement (assignment)) . (expression_statement (string) @rst))
 (#offset! @rst 0 3 0 -3))
(comment) @comment
]])
