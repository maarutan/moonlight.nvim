return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"mfussenegger/nvim-lint",
	},
	config = function()
		local icons = require("utils.constants.icons")

		for type, icon in pairs(icons.diagnostic) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end

		-- Diagnostics configuration
		vim.diagnostic.config({
			virtual_text = true, -- Show inline error/warning messages after the code
			update_in_insert = false, -- Do not update diagnostics while typing (in insert mode)
			underline = true, -- Underline problematic code sections
			severity_sort = true, -- Sort diagnostics by severity
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = icons.diagnostic.error,
					[vim.diagnostic.severity.WARN] = icons.diagnostic.warn,
					[vim.diagnostic.severity.INFO] = icons.diagnostic.info,
					[vim.diagnostic.severity.HINT] = icons.diagnostic.hint,
				},
			},
		})

		--- Python
		require("plugins.dev.lsp.python")

		--- Lua
		require("plugins.dev.lsp.lua")

		--- HTML, CSS, JS
		require("plugins.dev.lsp.typescript")
		require("plugins.dev.lsp.html")
		require("plugins.dev.lsp.css")
		require("plugins.dev.lsp.emmets")

		--- JSON, YAML, TOML
		require("plugins.dev.lsp.json")
		require("plugins.dev.lsp.yaml")
		require("plugins.dev.lsp.toml")

		-- --- Bash Zsh
		require("plugins.dev.lsp.sh")
	end,
}
