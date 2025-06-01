local on_attach = function(client, bufnr)
	local bufmap = function(keys, func)
		vim.keymap.set("n", keys, func, { buffer = bufnr })
	end

	bufmap("<leader>r", vim.lsp.buf.rename)
	bufmap("<leader>a", vim.lsp.buf.code_action)

	bufmap("gd", vim.lsp.buf.definition)
	bufmap("gD", vim.lsp.buf.declaration)
	bufmap("gI", vim.lsp.buf.implementation)
	bufmap("<leader>D", vim.lsp.buf.type_definition)

	bufmap("gr", require("telescope.builtin").lsp_references)
	bufmap("<leader>s", require("telescope.builtin").lsp_document_symbols)
	bufmap("<leader>S", require("telescope.builtin").lsp_dynamic_workspace_symbols)

	bufmap("K", vim.lsp.buf.hover)

	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format({ async = false })
		require("conform").format({ bufnr = bufnr })
	end, {})
	bufmap("<C-f>", ":Format<CR>")

	vim.api.nvim_create_autocmd("BufWritePre", {
		buffer = bufnr,
		callback = function()
			require("conform").format({
				bufnr = bufnr,
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			})
		end,
	})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("mason").setup()
require("mason-lspconfig").setup()
local lspconfig = require("lspconfig")
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black" },
	},
})
require("neodev").setup()
lspconfig.lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
vim.lsp.config("*", {
	on_attach = on_attach,
	capabilities = capabilities,
})
vim.lsp.enable("pyright")
vim.lsp.config("pyright", {
	on_attach = on_attach,
	capabilities = capabilities,
})
