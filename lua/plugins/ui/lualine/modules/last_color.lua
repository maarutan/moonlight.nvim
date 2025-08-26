local theme = require("last-color").recall() or "default"

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function(info)
		theme = info.match
	end,
})

local function normal_colors()
	local hl = vim.api.nvim_get_hl_by_name("Normal", true)
	local hl_border = vim.api.nvim_get_hl_by_name("FloatBorder", true)
	local hl_sep = vim.api.nvim_get_hl_by_name("WinSeparator", true)

	return {
		-- bg = hl.foreground and string.format("#%06x", hl.foreground),
		fg = hl.background and string.format("#%06x", hl_border.background),
		gui = "bold",
	}
end

local function get_bg(group)
	local ok, hl = pcall(vim.api.nvim_get_hl_by_name, group, true)
	if not ok or not hl.background then
		return nil
	end
	return string.format("#%06x", hl.background)
end

local bg_candidates = {
	"FloatBorder",
	"FloatTitle",
	"NormalFloat",
	"VertSplit",
	"StatusLine",
	"SignColumn",
}

local function border_color()
	local hl = vim.api.nvim_get_hl_by_name("FloatBorder", true)
	return {
		fg = hl.foreground and string.format("#%06x", hl.foreground),
		-- bg = hl.background and string.format("#%06x", hl.background),
		gui = "bold",
	}
end

return {
	icon = "󰝤",
	color = border_color(),
	function()
		return theme
	end,
}
