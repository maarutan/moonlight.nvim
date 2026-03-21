return function()
	local const = require("utils.constants")

	local items = {
		author = const.icons.ui.copyright .. "   " .. const.author.name,
		github = const.icons.git.clouds.github .. "   " .. const.author.app_github,
		line = "-----------------------------------------------",
		lua = const.icons.web_icons.files.lua .. "   " .. const.nvim.lua_version,
		version = const.icons.ui.nvim .. "   " .. const.nvim.version,
		terminal = const.icons.ui.mode.terminal .. "   " .. const.nvim.terminal,
	}

	local sort = { "author", "github", "line", "lua", "version", "terminal" }
	local result = "\n\n\n"
	for _, key in ipairs(sort) do
		result = result .. items[key] .. "\n"
	end

	return {
		text = result,
		align = "end",
		padding = 1,
		pane = 2,
		height = 10,
	}
end
