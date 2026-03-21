local const = require("utils.constants")

return {
	function()
		local theme = require("last-color").recall() or "default"

		local text = (#theme > 4) and (theme:sub(1, 4) .. "...") or theme

		return const.icons.ui.drawing_pen .. " " .. text
	end,

	color = function()
		local function hex(num)
			return num and string.format("#%06x", num) or nil
		end

		local hl = vim.api.nvim_get_hl(0, { name = "lualine_a_normal" })

		return {
			fg = hex(hl.bg),
			gui = "bold",
		}
	end,
}
