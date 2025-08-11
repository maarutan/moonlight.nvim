return {
	function()
		local status = require("codeium.virtual_text").status()

		if status.state == "idle" then
			return "󰘦 "
		elseif status.state == "waiting" then
			return "󰘦  Waiting..."
		elseif status.state == "completions" and status.total > 0 then
			return string.format("󰘦  %d/%d", status.current, status.total)
		else
			return "󰘦  0"
		end
	end,
}
