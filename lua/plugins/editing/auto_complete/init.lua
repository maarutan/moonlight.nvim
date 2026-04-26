return {
	"hrsh7th/nvim-cmp",
	version = "*",
	dependencies = {
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "hrsh7th/cmp-cmdline" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "onsails/lspkind.nvim" },
		{ "L3MON4D3/LuaSnip" },
		{ "windwp/nvim-autopairs" },
		{ "brenoprata10/nvim-highlight-colors" },
	},

	config = function()
		local cmp = require("cmp")
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")

		cmp.setup({
			-- ui
			window = require("plugins.editing.auto_complete.modules.window"),
			mapping = require("plugins.editing.auto_complete.modules.mappings.default"),
			formatting = require("plugins.editing.auto_complete.modules.formatting"),
			sources = require("plugins.editing.auto_complete.modules.sources"),
			experimental = {
				ghost_text = false,
			},

			cmp.setup.cmdline(
				":",
				require("plugins.editing.auto_complete.modules.mappings.cmdline")
			),
			cmp.setup.cmdline(
				{ "/", "?" },
				require("plugins.editing.auto_complete.modules.mappings.finder")
			),
		})
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

		--commands
		vim.cmd([[
            cnoremap <C-j> <C-n>
            cnoremap <C-k> <C-p>
        ]])
	end,
}
