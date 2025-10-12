local M = {}
local r = require

local SmoothTurn = r("utils.smooth_turn")
local helper = r("utils.helper")

M.select_all = r("utils.select_all")

M.scroll = SmoothTurn:new(
	function() return vim.cmd("normal! k") end,
	function()
		if not helper.is_cursor_bottom() then
			return vim.cmd("normal! j")
		else
			return vim.cmd(vim.api.nvim_replace_termcodes("normal! <C-e>", true, true, true))
		end
	end,
	4, -- max_steps
	30 -- interval (ms)
)

return M
