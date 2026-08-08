local lsp = require("utils.lsp")

lsp.setup_if_executable({
	name = "bashls",
	executable = "bash-language-server",
	config = {
		filetypes = { "sh", "bash", "zsh" },
		root_markers = { ".git" },
		settings = {
			bashIde = {
				globPattern = vim.env.GLOB_PATTERN
					or "*@(.sh|.inc|.bash|.command|.zsh|.zshrc|zshrc|.zprofile|.zlogin|.zlogout)",
			},
		},
	},
})
