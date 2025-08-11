return {

	function()
		local mode_map = {
			n = " NORMAL",
			i = " INSERT",
			v = "󰈈 VISUAL",
			V = "󰈈 V-Line",
			[""] = "󰈈 V-Block",
			c = " COMMAND",
			t = " TERMINAL",
			r = "󰑕 REPLACE",
			R = "󰑕 REPLACE",
		}
		return mode_map[vim.fn.mode()] or "󰑕 Unknown"
	end,
}
