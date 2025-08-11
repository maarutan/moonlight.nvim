return {
	function()
		local command = require("noice").api.status.command.get()
		if command and command ~= "" then
			return command
		else
			return "🚀"
		end
	end,
}
