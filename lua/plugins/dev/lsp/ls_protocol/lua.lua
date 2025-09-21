vim.lsp.config("lua_ls", {
	cmd = { "lua-language-server" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = vim.split(package.path, ";"),
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					vim.env.VIMRUNTIME,
					vim.fn.stdpath("config"),
				},
				checkThirdParty = false,
				preloadFileSize = 150,
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

vim.lsp.enable("lua_ls")
