-- local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("somesass_ls", {
	-- capabilities = capabilities,
	filetypes = { "sass", "scss", "less" },
})

vim.lsp.enable("somesass_ls")
