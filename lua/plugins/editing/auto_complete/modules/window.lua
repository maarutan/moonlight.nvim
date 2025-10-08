local r = require
local ui = r("utils.ui")

return {
	completion = {
		border = ui.border,
		winhighlight = ui.winhighlight,
		col_offset = 4,
	},
	documentation = {
		border = ui.border,
		winhighlight = ui.winhighlight,
	},
}
