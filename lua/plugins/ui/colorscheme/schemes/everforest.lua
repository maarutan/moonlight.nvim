return {
	"neanias/everforest-nvim",
	version = false,
	lazy = false,
	priority = 1000, -- make sure to load this before all the other start plugins
	-- Optional; default configuration will be used if setup isn't called.
	config = function()
		if vim.o.background == "light" then
			vim.g.everforest_background = "hard"
			vim.cmd([[
              highlight Cursor guifg=#BABABA guibg=#4C4F6A
              highlight CursorInsert guifg=#BABABA guibg=#4C4F6A
            ]])
		else
			vim.g.everforest_background = "medium"
			vim.cmd([[
              highlight Cursor guifg=#1E1E2E guibg=#BABABA
              highlight CursorInsert guifg=#1E1E2E guibg=#BABABA
            ]])
		end
		require("everforest").setup({
			on_highlights = function(hl, palette)
				hl.DiagnosticError = { fg = palette.none, bg = palette.none, sp = palette.red }
				hl.DiagnosticWarn = { fg = palette.none, bg = palette.none, sp = palette.yellow }
				hl.DiagnosticInfo = { fg = palette.none, bg = palette.none, sp = palette.blue }
				hl.DiagnosticHint = { fg = palette.none, bg = palette.none, sp = palette.green }
			end,
		})
	end,
}
