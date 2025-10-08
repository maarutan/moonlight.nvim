return {
	"hrsh7th/nvim-cmp",
	enalbed = true,
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
		local r = require
		local cmp = r("cmp")
		local cmp_autopairs = r("nvim-autopairs.completion.cmp")
		local m = "plugins.editing.auto_complete.modules."

		cmp.setup({
			-- ui
			window = r(m .. "window"),
			mapping = r(m .. "mappings.default"),
			formatting = r(m .. "formatting"),
			sources = r(m .. "sources"),
			experimental = {
				ghost_text = false,
			},

			cmp.setup.cmdline(":", r(m .. "mappings.cmdline")),
			cmp.setup.cmdline({ "/", "?" }, r(m .. "mappings.finder")),
		})
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

		--commands
		vim.cmd([[
            cnoremap <C-j> <C-n>
            cnoremap <C-k> <C-p>
        ]])
	end,
}
