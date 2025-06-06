return {
	{
		'mrcjkb/rustaceanvim',
		version = '^4', -- Recommended
		lazy = false,
		config = function()
			vim.keymap.set('n', '<C-f>', function(_)
				vim.lsp.buf.format()
			end)
			local bufmap = function(keys, func)
				vim.keymap.set('n', keys, func)
			end

			bufmap('<leader>r', vim.lsp.buf.rename)
			bufmap('<leader>a', vim.lsp.buf.code_action)

			bufmap('gd', vim.lsp.buf.definition)
			bufmap('gD', vim.lsp.buf.declaration)
			bufmap('gI', vim.lsp.buf.implementation)
			bufmap('<leader>D', vim.lsp.buf.type_definition)

			bufmap('gr', require('telescope.builtin').lsp_references)
			bufmap('<leader>s', require('telescope.builtin').lsp_document_symbols)
			bufmap('<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols)

			bufmap('K', vim.lsp.buf.hover)
		end, -- This plugin is already lazy
	}
}
