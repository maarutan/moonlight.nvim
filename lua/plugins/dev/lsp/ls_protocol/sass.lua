local lspconfig = require("lspconfig")

lspconfig.somesass_ls.setup({
	filetypes = { "sass", "scss", "less" },
})
