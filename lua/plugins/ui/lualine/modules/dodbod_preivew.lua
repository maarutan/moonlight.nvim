local const = require("utils.constants")

return {
	function()
		return vim.fn["db_ui#statusline"]({
			prefix = "DB: ",
			separator = " " .. const.icons.ui.arrows.right .. " ",
			show = { "db_name", "schema", "table" },
		})
	end,
}
