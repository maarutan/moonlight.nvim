local json = require("utils.json")
local icons = require("utils.constants.icons")
local config = require("plugins.tools.kitty_conf.config")

local M = {}

function M.notify()
	local data = json.load_file(config.kitty_json_base) or {}

	local font = data.font or "---"
	local size = data.size or "---"

	local render = string.format(
		[[{
  "font": "%s",
  "size": "%spx"
}]],
		font,
		size
	)

	vim.notify(render, vim.log.levels.WARN, {
		title = "Kitty Status",
		icon = icons.ui.kitty,
		timeout = 10000,
	})
end

return M
