local const = require("utils.constants")

return {
	indent_size = 3,
	padding = 2, -- extra padding on left hand side

	-- indent guides
	with_markers = true,
	indent_marker = const.icons.ui.listchars.indent_line,
	last_indent_marker = const.icons.ui.listchars.last_indent_marker
		.. const.icons.ui.listchars.horizontal_bar,
	highlight = "NeoTreeIndentMarker",

	-- expander config, needed for nesting files
	with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
	expander_collapsed = const.icons.ui.listchars.expander_collapsed,
	expander_expanded = const.icons.ui.listchars.expander_expanded,
	expander_highlight = "NeoTreeExpander",
}
