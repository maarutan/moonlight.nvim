local merge = require("utils.table").merge

return merge(
	{
		--- JS, CSS, HTML
		"typescript-language-server", --- npm
		"prettier", -- npm
		"emmet-ls", -- npm
		"html-lsp", -- npm
		"css-lsp", -- npm
    "eslint_d", -- npm

		--- Python
		"pyright", -- npm
		"ruff", -- pypi

		--- Lua
		"lua-language-server", -- github
		"stylua", -- github
    "selene", -- github

		--- Markdown
		"marksman", -- github

		--- Misc
		"bash-language-server", -- npm
		"yaml-language-server", -- npm
		"taplo", -- github
		"json-lsp", -- npm
	},
	require("plugins.dev.mason.tools_register.hyprland"),
	---
	require("plugins.dev.mason.tools_register.nixos")
)
