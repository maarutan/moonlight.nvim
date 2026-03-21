local M = {}

function M.list_fonts_unique()
	local seen, fonts = {}, {}
	local h = io.popen("fc-list : family")
	if not h then
		return fonts
	end

	for line in h:lines() do
		for font in line:gmatch("[^,]+") do
			font = font:gsub("^%s+", ""):gsub("%s+$", "")
			if font ~= "" and not seen[font] then
				seen[font] = true
				table.insert(fonts, font)
			end
		end
	end

	h:close()
	table.sort(fonts)
	return fonts
end

return M
