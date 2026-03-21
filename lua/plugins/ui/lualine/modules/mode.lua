local const = require("utils.constants")

return {
	function()
		local mode_map = {
			n = const.icons.ui.mode.normal .. " NORMAL",
			i = const.icons.ui.mode.insert .. " INSERT",
			v = const.icons.ui.mode.visual .. " VISUAL",
			V = const.icons.ui.mode.visual .. " V-Line",
			[""] = const.icons.ui.mode.visual .. " V-Block",
			c = const.icons.ui.mode.cmdline .. " COMMAND",
			t = const.icons.ui.mode.terminal .. " TERMINAL",
			r = const.icons.ui.mode.replace .. " REPLACE",
			R = const.icons.ui.mode.replace .. " REPLACE",
		}
		return mode_map[vim.fn.mode()] or const.icons.diagnostic.unknown .. " Unknown"
	end,
}
