return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"mfussenegger/nvim-lint",
	},
	config = function()
		local icons = require("utils.constants.icons")
		local servers = {
			"plugins.dev.lsp.python",
			"plugins.dev.lsp.lua",
			"plugins.dev.lsp.typescript",
			"plugins.dev.lsp.html",
			"plugins.dev.lsp.css",
			"plugins.dev.lsp.emmets",
			"plugins.dev.lsp.json",
			"plugins.dev.lsp.yaml",
			"plugins.dev.lsp.toml",
			"plugins.dev.lsp.sh",
			"plugins.dev.lsp.markdown",
			"plugins.dev.lsp.rust",
			"plugins.dev.lsp.c_cpp",
			"plugins.dev.lsp.java",
		}

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

		for _, server in ipairs(servers) do
			require(server)
		end
	end,
}
