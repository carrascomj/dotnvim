require("gitsigns").setup({
	signs = {
		-- TODO add hl to colorscheme
		add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
		change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
		delete = { hl = "GitSignsDelete", text = "", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		topdelete = { hl = "GitSignsDelete", text = "", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
	},
	numhl = true,
	linehl = false,
	keymaps = {
		-- Default keymap options
		noremap = true,
		buffer = true,
		["n gt"] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'" },
		["n gT"] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'" },
	},
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end
		-- toggle signs on keymap
		map("n", "<C-g>", function()
				local show_numhl = gs.toggle_numhl()
        gs.toggle_signs(show_numhl)
		end)
	end,
	watch_gitdir = {
		interval = 1000,
	},
	sign_priority = 6,
	update_debounce = 200,
	status_formatter = nil, -- Use default
})
