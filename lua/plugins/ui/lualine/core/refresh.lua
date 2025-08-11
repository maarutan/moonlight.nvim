return {
	statusline = 1000,
	tabline = 1000,
	winbar = 1000,
	refresh_time = 16, -- ~60fps
	events = {
		"WinEnter",
		"BufEnter",
		"BufWritePost",
		"SessionLoadPost",
		"FileChangedShellPost",
		"VimResized",
		"Filetype",
		"CursorMoved",
		"CursorMovedI",
		"ModeChanged",
	},
}
