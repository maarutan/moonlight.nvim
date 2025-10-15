local d = "plugins.ui."
local r = require

return {
	{ r(d .. "bufferline") },
	{ r(d .. "noice") },
	{ r(d .. "gitsigns") },
	{ r(d .. "cinnamon") },
	{ r(d .. "colorscheme") },
	{ r(d .. "highlight_colors") },
	{ r(d .. "highlight_log") },
	{ r(d .. "illuminate") },
	{ r(d .. "notify_macro") },
	{ r(d .. "matchup") },
	{ r(d .. "scrollview") },
	{ r(d .. "web_devicons") },

	-- status line
	{ r(d .. "lualine") },
}
