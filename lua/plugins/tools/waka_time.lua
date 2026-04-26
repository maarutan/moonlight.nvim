return {
	"wakatime/vim-wakatime",
	lazy = false,

	init = function()
		vim.g.loaded_wakatime = 1

		local notify = vim.notify

		---@diagnostic disable-next-line: duplicate-set-field
		vim.notify = function(msg, level, opts)
			if type(msg) == "string" and msg:find("%[WakaTime%]") then
				return
			end

			return notify(msg, level, opts)
		end
	end,

	config = function()
		require("wakatime").setup({
			debug = false,
			redraw_setting = "disabled",
			heartbeat_frequency = 5,
			status_bar_enabled = false,
		})
	end,
}
