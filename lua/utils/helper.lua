local M = {}

function M.is_cursor_bottom()
	local current_line = vim.api.nvim_win_get_cursor(0)[1]
	local total_lines = vim.api.nvim_buf_line_count(0)
	return current_line == total_lines
end

function M.is_cursor_top()
	local current_line = vim.api.nvim_win_get_cursor(0)[1]
	return current_line == 1
end

return M
