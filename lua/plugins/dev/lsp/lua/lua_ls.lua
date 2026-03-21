local lsp = require("utils.lsp")
local which = require("utils.which")
local tool = "lua_ls"

if not which:is_exists("lua-language-server") then
	return
end

vim.lsp.config(tool, {
	capabilities = lsp.capabilities(),
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					vim.fn.stdpath("config") .. "/lua",
				},
				maxPreload = 1000,
				preloadFileSize = 200,
			},
			completion = {
				callSnippet = "Disable",
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

vim.lsp.enable(tool)
