return function()
	local r = require
	local icons = r("utils.icons")

	local items = {
		author = icons.copyright .. "   maarutan",
		github = icons.clouds.github .. "   https://github.com/maarutan/moonlight.nvim",
		line = "-----------------------------------------------",
		lua = icons.languages.lua .. "   " .. _VERSION,
		version = icons.version .. "   " .. vim.api.nvim_command_output("version"):match("NVIM v[%d%.]+"),
		terminal = icons.terminal .. "   " .. vim.env.TERM,
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
