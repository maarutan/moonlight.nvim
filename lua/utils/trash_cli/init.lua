local os = require("utils.operating_system")

local backends = {
	[os.linux] = "utils.trash_cli.linux",
	[os.macos] = "utils.trash_cli.macos",
	[os.windows] = "utils.trash_cli.windows",
}

local current = os.get()
local backend = backends[current]

if not backend then
	error("Unsupported OS: " .. tostring(current))
end

return require(backend)
