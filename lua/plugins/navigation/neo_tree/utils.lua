local M = {}

local function witch(command)
	return vim.fn.executable(command) == 1
end

local function smoothScroll(key, delay, stop_int)
	local timer = vim.loop.new_timer()
	local line_count = vim.api.nvim_buf_line_count(0)
	local counter = 0
	timer:start(
		0,
		delay,
		vim.schedule_wrap(function()
			counter = counter + 1
			vim.cmd("normal! " .. key)

			if counter == stop_int then
				counter = 0
				timer:stop()
				timer:close()
			end
		end)
	)
end

M.smoothScroll = smoothScroll
M.witch = witch

return M
