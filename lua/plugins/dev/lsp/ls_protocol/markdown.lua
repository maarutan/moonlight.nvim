local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("marksman", {
	capabilities = capabilities,
	settings = {
		marksman = {
			workingDirectory = {
				mode = "auto", -- "auto" / "cwd" / "nearestAncestor"
			},
		},
	},
})

vim.lsp.enable("marksman")
