local paths = require("utils.paths")
local lsp = require("utils.lsp")

local ruff_enabled = lsp.setup_if_executable({
	name = "ruff",
	executable = "ruff",
	config = {
		init_options = {
			settings = {
				configuration = paths.nvim_config_dir() .. "/lua/plugins/dev/lsp/python/ruff.toml",
			},
		},
	},
})

if not ruff_enabled then
	return
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client.name == "ruff" then
			client.server_capabilities.hoverProvider = false
		end
	end,
})
