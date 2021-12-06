local define_augroups = function(definitions) -- {{{1
	-- Create autocommand groups based on the passed definitions
	--
	-- The key will be the name of the group, and each definition
	-- within the group should have:
	--    1. Trigger
	--    2. Pattern
	--    3. Text
	-- just like how they would normally be defined from Vim itself
	for group_name, definition in pairs(definitions) do
		vim.cmd("augroup " .. group_name)
		vim.cmd("autocmd!")

		for _, def in pairs(definition) do
			local command = table.concat(vim.tbl_flatten({ "autocmd", def }), " ")
			vim.cmd(command)
		end

		vim.cmd("augroup END")
	end
end

define_augroups({
	_general_settings = {
		{ "TextYankPost", "*", "lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 200})" },
	},
	_syntax = {
		{ "BufNewFile,BufRead,BufReadPost", "xmobarrc*", "set syntax=haskell" },
		{ "BufNewFile,BufRead,BufReadPost", "config", "set syntax=toml" },
		{ "BufRead", "config,xmobarrc*", "ColorizerToggle" },
		{ "BufNewFile,BufRead,BufReadPost", "polybar.config", "set syntax=toml" },
	},
	-- if wrapping is unset, at least wrap markdown
	-- _markdown = {{'FileType', 'markdown', 'setlocal wrap'}, {'FileType', 'markdown', 'setlocal spell'}},
	_buffer_bindings = {
		{ "FileType", "lspinfo", "nnoremap <silent> <buffer> q :q<CR>" },
		{ "FileType", "floaterm", "nnoremap <silent> <buffer> q :q<CR>" },
	},
})

vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])
