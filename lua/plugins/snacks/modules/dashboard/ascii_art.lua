return function()
	local which = require("utils.which")
	local img_path = vim.fn.stdpath("config") .. "/lua/assets/user.jpg"
	local logo_ascii = require("assets.user")

	local function get_size()
		local width = vim.o.columns
		if width < 30 then
			return 20, 10
		elseif width < 50 then
			return 30, 15
		elseif width < 100 then
			return 40, 20
		else
			return 50, 25
		end
	end

	local min_w, min_h = get_size()

	local function get_cmd()
		if which:is_exists("ascii-image-converter") then
			return string.format("ascii-image-converter %s -C -c -d %d,%d", img_path, min_w, min_h)
		else
			return string.format("echo '%s'", logo_ascii)
		end
	end

	local cmd = get_cmd()

	vim.api.nvim_create_autocmd("VimResized", {
		callback = function()
			min_w, min_h = get_size()
			cmd = get_cmd()
		end,
	})

	return {
		section = "terminal",
		cmd = cmd,
		pane = 2,
		height = min_h,
		width = min_w,
	}
end
