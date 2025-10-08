return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		local filenames = {
			"html",
			"css",
			"typescript",
			"lua",
			"python",
			"bash",
			"c_cpp",
			"json",
			"markdown",
			"sql",
			"hyprls",
			"emmet_ls",
			"nix",
			"rust",
			"django",
			"sass",
		}
		local r = require
		local d = "plugins.dev.lsp.modules."
		local icons = r("utils.icons")

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

		for _, i in ipairs(filenames) do
			r(d .. i)
		end
	end,
}
