local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

if not configs.django_template_language_server then
	configs.django_template_language_server = {
		default_config = {
			cmd = { "djlsp" },
			filetypes = { "htmldjango" },
			root_dir = lspconfig.util.root_pattern("manage.py", ".git"),
		},
	}
end

lspconfig.django_template_language_server.setup({
	capabilities = capabilities,
})
