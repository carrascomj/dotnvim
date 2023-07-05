vim.b['quarto_is_' .. 'python' .. '_chunk'] = false
Quarto_is_in_python_chunk = function()
	require 'otter.tools.functions'.is_otter_language_context('python')
end

vim.cmd [[
let g:slime_dispatch_ipython_pause = 100
function SlimeOverride_EscapeText_quarto(text)
call v:lua.Quarto_is_in_python_chunk()
if exists('g:slime_python_ipython') && len(split(a:text,"\n")) > 1 && b:quarto_is_python_chunk
return ["%cpaste -q\n", g:slime_dispatch_ipython_pause, a:text, "--", "\n"]
else
return a:text
end
endfunction
]]

function mark_terminal()
	vim.g.slime_last_channel = vim.b.terminal_job_id
	vim.print(vim.g.slime_last_channel)
end

function set_terminal()
	vim.b.slime_config = { jobid = vim.g.slime_last_channel }
end

vim.b.slime_cell_delimiter = "# %%"

-- slime, neovim terminal
vim.g.slime_target = "neovim"
vim.g.slime_python_ipython = 1
vim.g.slime_bracketed_paste = 0

-- -- slime, tmux
-- vim.g.slime_target = 'tmux'
-- vim.g.slime_default_config = { socket_name = "default", target_pane = ".2" }

-- vim.api.nvim_set_keymap('n','<leader>l', 'luaeval("mark_terminal()")<CR><C-w>w luaeval("set-terminal()")<CR>', { noremap = true, silent = true })
vim.keymap.set('n','<C-l>',
function()
	local fname = vim.fn.input("Terminal: ", "ipython")
	vim.cmd([[ vsplit term://]] .. fname)
	mark_terminal()
	vim.cmd[[ wincmd w ]]
	set_terminal()
end, { noremap = true, silent = true })

vim.api.nvim_set_keymap('n','<C-CR>', '<cmd>QuartoSend<CR>', { noremap = true, silent = true })

