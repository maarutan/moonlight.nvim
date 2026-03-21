local icons = require("utils.constants.icons")
local merge = require("utils.table").merge

return merge(
	require("plugins.tools.keymaps.ccc"),
	require("plugins.tools.keymaps.git_graph"),
	require("plugins.tools.keymaps.toggle_terminal"),
	require("plugins.tools.keymaps.toggle_word"),
	require("plugins.tools.keymaps.lspsaga"),
	require("plugins.tools.keymaps.kitty_conf")
)
