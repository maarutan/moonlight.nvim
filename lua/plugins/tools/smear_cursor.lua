local r = require
local terminal = r("utils.terminal")

return {
	"sphamba/smear-cursor.nvim",
	event = "VeryLazy",
	enabled = function()
		if not terminal:is_kitty() then return true end
	end,
	opts = {
		smear_between_buffers = true,
		smear_between_neighbor_lines = true,
		scroll_buffer_space = true,
		legacy_computing_symbols_support = false,
		smear_insert_mode = true,
	},
}
