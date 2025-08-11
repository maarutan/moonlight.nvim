return {

	icon = "  LSP:",
	color = { fg = "#ffffff", gui = "bold" },
	function()
		local bufnr = vim.api.nvim_get_current_buf()
		local clients = vim.lsp.get_clients({ bufnr = bufnr })

		if not clients or #clients == 0 then
			return "[ LSP - Disabled ]"
		end

		local names = {}
		for _, client in ipairs(clients) do
			table.insert(names, client.name or "Unknown")
		end

		return table.concat(names, " | ")
	end,
}
