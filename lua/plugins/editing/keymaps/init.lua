local merge = require("utils.table").merge
local icons = require("utils.constants.icons")

return merge(
	require("plugins.editing.keymaps.bufdelete"),
	require("plugins.editing.keymaps.comments"),
	require("plugins.editing.keymaps.multicursor"),
	require("plugins.editing.keymaps.go_move"),
	require("plugins.editing.keymaps.surround")
)
