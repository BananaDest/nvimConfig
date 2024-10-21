require('telescope').setup({
	extensions = {
		fzf = {
			fuzzy = true,              -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case",  -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		}
	}
})

require('telescope').load_extension('fzf')
local bufmap = function(keys, func)
	vim.keymap.set('n', keys, func)
end
bufmap('<leader>ff', require('telescope.builtin').find_files)
bufmap('<leader>fg', require('telescope.builtin').live_grep)
bufmap('<leader>fb', require('telescope.builtin').buffers)
bufmap('<leader>fh', require('telescope.builtin').help_tags)
