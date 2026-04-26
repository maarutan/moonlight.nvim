local which = require("utils.which")
local lsp = require("utils.lsp")
local tool = "bashls"

if not which:is_exists("bash-language-server") then
	return
end

vim.lsp.config(tool, {
	capabilities = lsp.capabilities(),
	filetypes = { "sh", "bash", "zsh" },
	settings = {
		bashIde = {
			globPattern = vim.env.GLOB_PATTERN
				or "*@(.sh|.inc|.bash|.command|.zsh|.zshrc|zshrc|.zprofile|.zlogin|.zlogout)",
		},
	},
})

vim.lsp.enable(tool)
