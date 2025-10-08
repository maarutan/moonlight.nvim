local r = require
local icons = r("utils.icons")

return {
    indent_size = 3,
    padding = 2, -- extra padding on left hand side

    -- indent guides
    with_markers = true,
    indent_marker = icons.indent_line,
    last_indent_marker = icons.last_indent_marker .. icons.horizontal_bar,
    highlight = "NeoTreeIndentMarker",

    -- expander config, needed for nesting files
    with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
    expander_collapsed = icons.expander_collapsed,
    expander_expanded = icons.expander_expanded,
    expander_highlight = "NeoTreeExpander",
}
