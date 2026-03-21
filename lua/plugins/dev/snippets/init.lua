return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	event = "InsertEnter",
	dependencies = { "rafamadriz/friendly-snippets" },
	config = function()
		local luasnip = require("luasnip")

		require("luasnip.loaders.from_vscode").lazy_load()
		require("plugins.dev.snippets.custom.pyright")
		require("plugins.dev.snippets.custom.python")

		luasnip.config.set_config({
			history = true,
			updateevents = "TextChanged,TextChangedI",
			enable_autosnippets = true,
		})
	end,
}
