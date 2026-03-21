return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff_format" },
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			html = { "prettier" },
			css = { "prettier" },
			sh = { "shfmt" },
			sass = { "sass-formater" },
			scss = { "prettier" },
			xml = { "xmlformat" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			markdown = { "prettier" },
			json = { "prettier" },
			jsonc = { "prettier" },
		},

		format_on_save = {
			timeout_ms = 300,
			lsp_fallback = true,
		},
	},
}
