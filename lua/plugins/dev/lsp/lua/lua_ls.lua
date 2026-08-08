local lsp = require("utils.lsp")

lsp.setup_if_executable({
	name = "lua_ls",
	executable = "lua-language-server",
	config = {
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
	},
})
