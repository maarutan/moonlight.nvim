local lsp_status_component = {
	function()
		local bufnr = vim.api.nvim_get_current_buf()
		local clients = vim.lsp.get_clients({ bufnr = bufnr })
		if not clients or #clients == 0 then
			return "[ LSP - Disabled ]"
		end
		return ""
	end,
}
return lsp_status_component
