return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	event = "InsertEnter",
	dependencies = { "rafamadriz/friendly-snippets" },
	config = function()
		local r = require
		local luasnip = r("luasnip")

		r("luasnip.loaders.from_vscode").lazy_load()
		r("plugins.dev.snippets.custom.pyright")

		luasnip.config.set_config({
			history = true,
			updateevents = "TextChanged,TextChangedI",
			enable_autosnippets = true,
		})
	end,
}
