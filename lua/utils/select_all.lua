local function select_all()
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))

	vim.cmd("normal! ggVG")

	local restore_group = vim.api.nvim_create_augroup("SelectAllRestoreGroup", { clear = true })

	vim.api.nvim_create_autocmd("ModeChanged", {
		group = restore_group,
		pattern = "*:*",
		callback = function()
			pcall(vim.api.nvim_del_augroup_by_id, restore_group)

			local line_count = vim.api.nvim_buf_line_count(0)
			local target_row = math.min(row, line_count)
			pcall(vim.api.nvim_win_set_cursor, 0, { target_row, col })

			vim.cmd("normal! zz")
		end,
		once = true,
	})
end

return select_all
