local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("nil_ls", {
	cmd = { "nil" },
	filetypes = { "nix" },
	capabilities = capabilities,
	root_dir = vim.fs.root(0, { "flake.nix", "shell.nix", "configuration.nix", "disko.nix" }),
})

vim.lsp.enable("nil_ls")
