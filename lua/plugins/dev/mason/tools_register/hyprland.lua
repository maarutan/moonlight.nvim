local which = require("utils.which")

if which:is_exists("hyprctl") then
	return { "hyprls" }
end

return nil
