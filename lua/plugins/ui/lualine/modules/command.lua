local const = require("utils.constants")
local which = require("utils.which")
local module_name = "noice"

return {
	function()
		local ok, noice = which:is_module_exists(module_name)
		if not ok or not noice or not noice.api or not noice.api.status or not noice.api.status.command then
			return "[ " .. const.icons.diagnostic.warn .. " not found `noice` ]"
		end

		local command = noice.api.status.command.get()

		if command and command ~= "" then
			if command:sub(1, 1) == "<" or command == "j" then
				return " " .. const.icons.ui.command .. " "
			else
				return command
			end
		else
			return " " .. const.icons.ui.command .. " "
		end
	end,

	color = function()
		local ok, _ = which:is_module_exists(module_name)
		if not ok then
			return { fg = "#990000" }
		else
			return { fg = "#ffffff" }
		end
	end,
}
