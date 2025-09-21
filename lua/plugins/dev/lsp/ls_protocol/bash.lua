local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("bashls", {
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		print("Bash LSP connected → buffer " .. bufnr)
	end,
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
