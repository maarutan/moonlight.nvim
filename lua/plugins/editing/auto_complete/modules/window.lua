local options = require("core.options")
local winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None"

return {
	completion = {
		border = options.border,
		winhighlight = winhighlight,
		col_offset = 4,
	},
	documentation = {
		border = options.border,
		winhighlight = winhighlight,
	},
}
