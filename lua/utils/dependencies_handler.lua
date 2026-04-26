local os = require("utils.operating_system")
local which = require("utils.which")
local const = require("utils.constants")

local M = {}

local deps_map = {
	[os.linux] = {
		"git",
		"curl",
		"node",
		"npm",
		"python3",
		"pip",
		"tar",
		"unzip",
	},
	[os.macos] = { "git" },
	[os.windows] = { "git" },
}

local os_type = os.get()
local deps = deps_map[os_type] or {}

local is_not_found_deps = false
local not_found_deps = {}

for _, dep in ipairs(deps) do
	if not which:is_exists(dep) then
		table.insert(not_found_deps, dep)
		is_not_found_deps = true
	end
end

if is_not_found_deps then
	local bar_top = string.rep(const.icons.ui.listchars.horizontal_bar, 66)
	local bar_bottom = string.rep(const.icons.ui.listchars.horizontal_bar, 50)

	vim.api.nvim_err_writeln(bar_top)
	vim.api.nvim_out_write("\n")

	vim.api.nvim_out_write(const.nvim.header .. "\n")
	vim.api.nvim_out_write(const.nvim.moons .. "\n\n")

	vim.api.nvim_out_write(
		string.format(
			"os           : %s\nApplication  : %s\nnvim version : %s\nlua version  : %s\nterminal     : %s\n\n",
			os_type,
			const.nvim.name,
			const.nvim.version,
			const.nvim.lua_version,
			const.nvim.terminal
		)
	)

	for _, dep in ipairs(not_found_deps) do
		vim.api.nvim_err_writeln(
			string.format(
				"   %s [not found]  Dependency   =   '%s'",
				const.icons.diagnostic.warn,
				dep
			)
		)
	end

	vim.api.nvim_err_writeln(bar_bottom)
	vim.api.nvim_out_write("\n\n")

	return
end

return M
