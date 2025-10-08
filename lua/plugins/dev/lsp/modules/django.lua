local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")

if not configs.django_template_language_server then
	configs.django_template_language_server = {
		default_config = {
			cmd = { "djlsp" },
			filetypes = { "htmldjango" },
			root_dir = lspconfig.util.root_pattern("manage.py", ".git"),
		},
	}
end
