local M = {}

local r = require
local d = "plugins.tools.kitty_term."
local icons = r("utils.icons")
local json = r("utils.json")
local config = vim.fn.stdpath("config") .. "/" .. r(d .. "config").setup.config_path

local function dump(tbl, indent)
	indent = indent or 0
	if type(tbl) ~= "table" then return tostring(tbl) end

	local lines = {}
	local prefix = string.rep("  ", indent)
	table.insert(lines, "{")

	for k, v in pairs(tbl) do
		local key = tostring(k)
		local value
		if type(v) == "table" then
			value = dump(v, indent + 1)
		elseif type(v) == "string" then
			value = string.format("%q", v)
		else
			value = tostring(v)
		end
		table.insert(lines, string.rep("  ", indent + 1) .. key .. " = " .. value .. ",")
	end

	table.insert(lines, prefix .. "}")
	return table.concat(lines, "\n")
end

function M.status()
	vim.notify(dump(json.load(config)), vim.log.levels.WARN, {
		title = "kitty Term",
		icon = icons.kitty.title,
		timeout = 10000,
	})
end

return M
