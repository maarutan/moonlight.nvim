local signs = require("core.options").signs
-- programming language
require("plugins.dev.lsp.init")

-- treesitter
require("plugins.dev.treesitter.context")
require("plugins.dev.treesitter.sintax_highlight")

-- fromatters
require("plugins.dev.formatters.init")

-- Mason
require("plugins.dev.mason")

-- snippets
require("plugins.dev.snippets.luasnip")

-- keymaps
require("plugins.dev.keymaps")

for type, icon in pairs(signs) do
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
			[vim.diagnostic.severity.ERROR] = signs.error,
			[vim.diagnostic.severity.WARN] = signs.warn,
			[vim.diagnostic.severity.INFO] = signs.info,
			[vim.diagnostic.severity.HINT] = signs.hint,
		},
	},
})
