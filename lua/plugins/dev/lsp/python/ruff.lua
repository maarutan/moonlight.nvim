local which = require("utils.which")
local paths = require("utils.paths")
local lsp = require("utils.lsp")
local tool = "ruff"

if not which:is_exists(tool) then
	return
end

vim.lsp.config(tool, {
	capabilities = lsp.capabilities(),
	init_options = {
		settings = {
			configuration = paths.nvim_config_dir() .. "/lua/plugins/dev/lsp/python/ruff.toml",
		},
	},
})

vim.lsp.enable(tool)

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client.name == tool then
			client.server_capabilities.hoverProvider = false
		end
	end,
})
