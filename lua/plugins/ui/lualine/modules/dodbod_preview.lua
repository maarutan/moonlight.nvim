return {
	function()
		return vim.fn["db_ui#statusline"]({
			prefix = "DB: ",
			separator = " -> ",
			show = { "db_name", "schema", "table" },
		})
	end,
}
