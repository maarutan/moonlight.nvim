local r = require
local icons = r("utils.icons")

return {
	function()
		local mode_map = {
			n = icons.mode.normal .. " NORMAL",
			i = icons.mode.insert .. " INSERT",
			v = icons.mode.visual .. " VISUAL",
			V = icons.mode.visual .. " V-Line",
			[""] = icons.mode.visual .. " V-Block",
			c = icons.mode.cmdline .. " COMMAND",
			t = icons.mode.terminal .. " TERMINAL",
			r = icons.mode.replace .. " REPLACE",
			R = icons.mode.replace .. " REPLACE",
		}
		return mode_map[vim.fn.mode()] or icons.unknown .. " Unknown"
	end,
}
