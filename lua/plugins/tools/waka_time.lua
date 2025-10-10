return {
	"wakatime/vim-wakatime",
	enabled = true,
	lazy = false,
	config = function()
		if vim.fn.filereadable(vim.fn.expand("~/.wakatime.cfg")) == 0 then vim.g.wakatime_enabled = 0 end
	end,
}
