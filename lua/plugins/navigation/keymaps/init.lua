local icons = require("utils.constants.icons")
local merge = require("utils.table").merge

return merge(
	require("plugins.navigation.keymaps.neo_tree"),
	require("plugins.navigation.keymaps.hop")
)
