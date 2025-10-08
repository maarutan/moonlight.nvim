return {
	"numToStr/Comment.nvim",
	version = "*",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		local r = require
		local ts_cc = r("ts_context_commentstring")
		local ts_cc_integration = r("ts_context_commentstring.integrations.comment_nvim")
		local comment = r("Comment")

		ts_cc.setup({
			enable_autocmd = false,
		})

		comment.setup({
			padding = true,
			sticky = true,
			ignore = "^$",
			pre_hook = ts_cc_integration.create_pre_hook(),
		})
	end,
}
