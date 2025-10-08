vim.lsp.config("marksman", {
	settings = {
		marksman = {
			workingDirectory = {
				mode = "auto", -- "auto" / "cwd" / "nearestAncestor"
			},
		},
	},
})

vim.lsp.enable("marksman")
