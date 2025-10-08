vim.lsp.config("ts_ls", {
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
		print("TypeScript LSP attached → buffer " .. bufnr)
	end,
	settings = {
		javascript = {
			format = {
				semicolons = "insert",
			},
		},
		typescript = {
			format = {
				semicolons = "insert",
			},
		},
	},
	filetypes = {
		"typescript",
		"javascript",
		"typescriptreact",
		"javascriptreact",
		"javascript.jsx",
		"typescript.tsx",
	},
})

vim.lsp.enable("ts_ls")
