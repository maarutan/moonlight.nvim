return {
	"numToStr/Comment.nvim",
	version = "*",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		require("ts_context_commentstring").setup({
			enable_autocmd = false,
		})

		require("Comment").setup({
			padding = true,
			sticky = true,
			ignore = "^$",
			pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
		})
	end,
}
