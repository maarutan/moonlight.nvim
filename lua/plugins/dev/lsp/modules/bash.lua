vim.lsp.config("bashls", {
	on_attach = function(client, bufnr) print("Bash LSP connected → buffer " .. bufnr) end,
	settings = {
		bash = {
			shellcheck = {
				enable = true,
			},
			explainShell = {
				enable = true,
			},
		},
	},
	filetypes = { "sh", "bash", "zsh" },
})

vim.lsp.enable("bashls")
