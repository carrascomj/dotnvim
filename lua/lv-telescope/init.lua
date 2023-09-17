local actions = require("telescope.actions")
local putils = require("telescope.previewers.utils")
local path = require("plenary.path")
-- Global remapping
------------------------------
-- '--color=never',
require("telescope").setup({
	defaults = {
		find_command = { "rg", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
		vimgrep_arguments = {
			"rg",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		prompt_prefix = "❯ ",
		results_title = "",
		selection_caret = "❯ ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		layout_config = {
			height = 0.8,
			preview_cutoff = 80,
			prompt_position = "top",
			horizontal = { mirror = false },
			vertical = { mirror = false },
		},
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		file_ignore_patterns = {},
		generic_sorter = require("telescope.sorters").get_native_fuzzy_sorter,
		-- border = {},
		borderchars = {
			{ "─", "│", "─", "│", "┌", "┐", "┘", "└" },
			prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
			results = { " ", "│", "─", "│", "│", "│", "╯", "╰" },
			-- preview = { '─', '│', '─', '│', '┌', '┐', "┘", "└"},
			preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		},
		-- borderchars = {'─', '│', '─', '│', "┌", "┐", "┘", "└"},
		color_devicons = true,
		use_less = true,
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

		-- Developer configurations: Not meant for general override
		buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
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
				["<CR>"] = actions.select_default + actions.center,

				-- You can perform as many actions in a row as you like
				-- ["<CR>"] = actions.select_default + actions.center + my_cool_custom_action,
			},
			n = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
				-- ["<C-i>"] = my_cool_custom_action,
			},
		},
	},
})

-- Insert a line and close the Telescope window
local function insert_line_with(line, prompt_bufnr, mode)
	-- disable autopairs so it doesn't get crazy with the ("
	mode = mode or "o"
	require("nvim-autopairs").disable()
	vim.api.nvim_set_var("matched", line)
	print(line)
	actions.close(prompt_bufnr)
	vim.cmd([[exe "normal! ]] .. mode .. [[" . matched]])
	require("nvim-autopairs").enable()
end

local M = {}
-- show a fuzzy summary of a SBML file at root_dir .. @"
-- The SBML file is taken from input and then looked up in the working dir
M.fdsbml = function()
	local model_file
	require("plenary.job")
		:new({
			command = "fd",
			args = { "-F", "-p", vim.fn.input("SBML file: ") },
			on_exit = function(j, _)
				model_file = j:result()[1]
			end,
		})
		:sync()
	-- Show on the status the file that we took
	print(model_file)
	require("telescope.pickers").new({
		results_title = "SBML summary",
		prompt_prefix = " ",
		finder = require("telescope.finders").new_oneshot_job({ "fdsbml", model_file }),
		sorter = require("telescope.sorters").get_fzy_sorter(),
		attach_mappings = function(prompt_bufnr, map)
			-- On enter, insert cobrapy-like accession on the next line
			map("i", "<CR>", function(bufnr)
				local content = require("telescope.actions.state").get_selected_entry(bufnr)
				local match = content.value:match([[ ([a-zA-Z0-9_-]+): ]])
				if content.value:match([[Reaction]]) then
					match = [[model.reactions.get_by_id("]] .. match:sub(3) .. [[")]]
				elseif match:match("prot_") then
					match = [[model.proteins.get_by_id("]] .. match:sub(3) .. [[")]]
				elseif match:match("^M_") then
					match = [[model.metabolites.get_by_id("]] .. match:sub(3) .. [[")]]
				end
				insert_line_with(match, prompt_bufnr)
			end)
			-- On Ctrl-i, insert just the identifier
			map("i", "<C-i>", function(bufnr)
				local content = require("telescope.actions.state").get_selected_entry(bufnr)
				local match = content.value:match([[ ([a-zA-Z0-9_-]+): ]])
				insert_line_with(match:sub(3), prompt_bufnr, "a")
			end)
			return true
		end,
	}):find()
end

-- Implementation stolen from telescope-bibtext that I could not install myself
local function end_of_entry(line, par_mismatch)
	local line_blank = line:gsub("%s", "")
	for _ in (line_blank):gmatch("{") do
		par_mismatch = par_mismatch + 1
	end
	for _ in (line_blank):gmatch("}") do
		par_mismatch = par_mismatch - 1
	end
	return par_mismatch == 0
end

local function read_file()
	local entries = {}
	local contents = {}
	local p = path:new([[bibliography.bib]])
	if not p:exists() then
		return {}
	end
	local current_entry = ""
	local in_entry = false
	local par_mismatch = 0
	for line in p:iter() do
		if line:match("@%w*{") then
			in_entry = true
			par_mismatch = 1
			local entry = line:gsub("@%w*{", "")
			entry = entry:sub(1, -2)
			current_entry = entry
			table.insert(entries, entry)
			contents[current_entry] = { line }
		elseif in_entry and line ~= "" then
			table.insert(contents[current_entry], line)
			if end_of_entry(line, par_mismatch) then
				in_entry = false
			end
		end
	end
	return entries, contents
end

local function get_results()
	local results = {}
	local result, content = read_file()
	for _, entry in pairs(result) do
		table.insert(results, { name = entry, content = content[entry] })
	end
	return results
end

M.bib = function()
	local results = get_results()
	require("telescope.pickers").new({
		results_title = "Bibliography",
		prompt_prefix = "龎",
		finder = require("telescope.finders").new_table({
			results = results,
			entry_maker = function(line)
				return {
					value = line.name,
					ordinal = line.name,
					display = line.name,
					preview_command = function(entry, bufnr)
						vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, results[entry.index].content)
						putils.highlighter(bufnr, "bib")
					end,
				}
			end,
		}),
		-- the selected entry will be accessed through results, which has the content
		previewer = require("telescope.previewers").display_content.new(results),
		sorter = require("telescope.sorters").get_fzy_sorter(),
		attach_mappings = function(prompt_bufnr, map)
			-- On enter, insert "\autocite{ref}"
			map("i", "<cr>", function(bufnr)
				local content = require("telescope.actions.state").get_selected_entry(bufnr)
				local match = content.value
				insert_line_with([[\autocite{]] .. match .. [[}]], prompt_bufnr, "a")
			end)
			-- the ref id itself
			map("i", "<C-i>", function(bufnr)
				local content = require("telescope.actions.state").get_selected_entry(bufnr)
				local match = content.value
				insert_line_with(match, prompt_bufnr, "a")
			end)
			return true
		end,
	}):find()
end

M.search_dotfiles = function()
	require("telescope.builtin").find_files({
		find_command = { "fd" },
		prompt_title = "< VimRC >",
		cwd = "/home/georg/.config/nvim",
		hidden = true,
	})
end

return M
