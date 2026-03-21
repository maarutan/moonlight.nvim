local os = require("utils.operating_system")

if os.get_os_id() == "nix" then
	return { "nil", "alejandra" }
end

return nil
