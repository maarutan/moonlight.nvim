vim.lsp.config("rust_analyzer", {
	settings = {
		["rust-analyzer"] = {
			checkOnSave = { command = "check" },
		},
	},
})

vim.lsp.enable("rust_analyzer")
