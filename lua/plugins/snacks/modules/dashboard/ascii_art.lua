return function()
	local r = require
	local which = r("utils.which")
	local img_path = vim.fn.stdpath("config") .. "/lua/assets/user.jpg"
	local logo_ascii = r("assets.user")

	local min_w, min_h = 40, 20

	local cmd
	if which:is_exists("ascii-image-converter") then
		cmd = string.format("ascii-image-converter %s -C -c -d %d,%d", img_path, min_w, min_h)
	else
		cmd = string.format("echo '%s'", logo_ascii)
	end

	return {
		section = "terminal",
		cmd = cmd,
		pane = 2,
		height = min_h,
		width = min_w,
	}
end
