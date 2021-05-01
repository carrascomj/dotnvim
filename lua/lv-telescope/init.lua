local actions = require('telescope.actions')
-- Global remapping
------------------------------
-- '--color=never',
require('telescope').setup {
    defaults = {
        find_command = {'rg', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case'},
				vimgrep_arguments = {
							'rg',
							'--no-heading',
							'--with-filename',
							'--line-number',
							'--column',
							'--smart-case'
				},
        prompt_position = "top",
        prompt_prefix = "❯ ",
        results_title = "",
        selection_caret = "❯ ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_defaults = {horizontal = {mirror = false}, vertical = {mirror = false}},
        file_sorter = require'telescope.sorters'.get_fuzzy_file,
        file_ignore_patterns = {},
        generic_sorter = require'telescope.sorters'.get_native_fuzzy_sorter,
        shorten_path = true,
        width = 0.6,
        preview_cutoff = 80,
        results_height = 0.3,
        results_width = 0.6,
        -- border = {},
				borderchars = {
							{ '─', '│', '─', '│', '┌', '┐', '┘', '└'},
							prompt = {"─", "│", " ", "│", '┌', '┐', "│", "│"},
							results = {" ", "│", "─", "│", "│", "│", "┘", "└"},
							preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
				},
				-- borderchars = {'─', '│', '─', '│', "┌", "┐", "┘", "└"},
        color_devicons = true,
        use_less = true,
        set_env = {['COLORTERM'] = 'truecolor'}, -- default = nil,
        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                -- To disable a keymap, put [map] = false
                -- So, to not map "<C-n>", just put
                -- ["<c-x>"] = false,
                ["<esc>"] = actions.close,

                -- Otherwise, just set the mapping to the function that you want it to be.
                -- ["<C-i>"] = actions.select_horizontal,

                -- Add up multiple actions
                ["<CR>"] = actions.select_default + actions.center

                -- You can perform as many actions in a row as you like
                -- ["<CR>"] = actions.select_default + actions.center + my_cool_custom_action,
            },
            n = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                -- ["<C-i>"] = my_cool_custom_action,
            }
        }
    }
}
require('telescope').load_extension('fzy_native')

-- Insert a line and close the Telescope window
local function insert_line_with(line, prompt_bufnr, mode)
	-- disable autopairs so it doesn't get crazy with the ("
	mode = mode or "o"
	require('nvim-autopairs').disable()
	vim.api.nvim_set_var("matched", line)
	print(line)
	actions.close(prompt_bufnr)
	vim.cmd([[exe "normal! ]] .. mode .. [[" . matched]])
	require('nvim-autopairs').enable()
end

local M = {}
-- show a fuzzy summary of a SBML file at root_dir .. @"
M.fdsbml = function()
	-- copy register (Yanked) to variable
	vim.cmd([[let xxx=@"]])
	local model_file
	require('plenary.job'):new({
		command = "fd", cwd=vim.fn.getcwd(),
		args = {"-F", "-p", vim.g.xxx},
		on_exit= function(j, _)
			model_file = j:result()[1]
		end
	}):sync()
	-- Show on the status the file that we took
	print(model_file)
	require('telescope.pickers').new {
		prompt_prefix = " ",
		finder = require('telescope.finders').new_oneshot_job(
			{ 'fdsbml', model_file }
		),
		results_title = 'SBML summary',
		sorter = require('telescope.sorters').get_fzy_sorter(),
		attach_mappings = function(prompt_bufnr, map)
			-- On enter, insert cobrapy-like accession on the next line
			map('i', '<CR>', function(bufnr)
				local content = require('telescope.actions.state').get_selected_entry(bufnr)
				local match = content.value:match([[ ([a-zA-Z0-9_-]+): ]])
				if (content.value:match([[Reaction]])) then
					match = [[model.reactions.get_by_id("]] .. match:sub(3) .. [[")]]
					elseif (match:match("prot_")) then
					match = [[model.proteins.get_by_id("]] .. match:sub(3) .. [[")]]
					elseif (match:match("^M_")) then
					match = [[model.metabolites.get_by_id("]] .. match:sub(3) .. [[")]]
				end
				insert_line_with(match, prompt_bufnr)
			end)
			-- On Ctrl-i, insert just the identifier
			map('i', '<C-i>', function(bufnr)
				local content = require('telescope.actions.state').get_selected_entry(bufnr)
				local match = content.value:match([[ ([a-zA-Z0-9_-]+): ]])
				insert_line_with(match:sub(3), prompt_bufnr, "a")
			end)
			return true
		end
	}:find()
end

return M


