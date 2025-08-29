local smoothScroll = require("plugins.navigation.neo_tree.utils").smoothScroll
local trash = require("plugins.navigation.neo_tree.commands_modules.trash").trash
local M = {}

M.scrollup = function(state)
	smoothScroll("k", 30, 3)
end

M.scrolldown = function(state)
	smoothScroll("j", 30, 3)
end

M.trash = trash
M.resotre = function(state)
	vim.cmd("BRestore")
	require("neo-tree.sources.manager").refresh(state)
end

return M
