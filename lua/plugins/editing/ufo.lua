return {
	"kevinhwang91/nvim-ufo",
	dependencies = { "kevinhwang91/promise-async" },
	opts = {
		provider_selector = function(_, _, _) return { "lsp", "indent" } end,
		fold_virt_text_handler = nil,
	},
	config = function(_, opts)
		local ufo = require("ufo")
		ufo.setup(opts)

		vim.o.foldenable = true
		vim.o.foldnestmax = 10
		vim.o.foldlevel = 99
		vim.o.foldlevelstart = 99

		vim.keymap.set("n", "zN", ufo.openAllFolds, { silent = true })
		vim.keymap.set("n", "zM", ufo.closeAllFolds, { silent = true })
	end,
}
