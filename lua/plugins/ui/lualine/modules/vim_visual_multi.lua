return {
	function()
		if vim.fn.exists("b:VM_Selection") == 1 and not vim.tbl_isempty(vim.b.VM_Selection) then
			local status = vim.fn["VMInfos"]().status:lower()
			local replacements = {
				["active"] = "󱢓 MCursor:",
			}
			return replacements[status] or status
		else
			return ""
		end
	end,
}
