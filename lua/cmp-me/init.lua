local lspkind = require("lspkind")
lspkind.init()
local cmp = require("cmp")

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({
	snippet = {
		expand = function(args)
			-- For `vsnip` user.
			vim.fn["vsnip#anonymous"](args.body)

			-- For `luasnip` user.
			-- require('luasnip').lsp_expand(args.body)

			-- For `ultisnips` user.
			-- vim.fn["UltiSnips#Anon"](args.body)
		end,
	},
	mapping = {
		-- ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-n>"] = cmp.mapping(function(fallback)
			-- jump to next item in the completion menu or jump to position on snippet.
			if cmp.visible() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
			elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
			else fallback()
			end
		end),
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.confirm({select = true}),
	},
	formatting = {
		-- Youtube: How to set up nice formatting for your sources.
		format = lspkind.cmp_format({
			with_text = true,
			menu = {
				buffer = "[buf]",
				nvim_lsp = "[LSP]",
				nvim_lua = "[api]",
				path = "[path]",
				luasnip = "[snip]",
				gh_issues = "[issues]",
			},
		}),
	},
	experimental = {
		native_menu = false,
		ghost_text = true,
	},
	sources = {
		{ name = "nvim_lsp" },

		-- For vsnip user.
		{ name = "vsnip" },

		-- For luasnip user.
		-- { name = 'luasnip' },

		-- For ultisnips user.
		-- { name = 'ultisnips' },

		{ name = "path" },
		{ name = "buffer" },
	  -- For quarto
		{ name = "otter" },
	},
})
