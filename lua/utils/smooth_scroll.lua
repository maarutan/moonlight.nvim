local SmoothTurn = require("utils.smooth_turn")
local Cursor = require("utils.cursor")

local M = {}

local scroll = SmoothTurn:new(
	function() -- up_fn
		return vim.cmd("normal! k")
	end,
	function() -- down_fn
		if not Cursor.is_bottom() then
			return vim.cmd("normal! j")
		else
			return vim.cmd(vim.api.nvim_replace_termcodes("normal! <C-e>", true, true, true))
		end
	end,
	4, -- max_steps
	30 -- interval ms
)

function M.up()
	scroll:start(true)
end

function M.down()
	scroll:start(false)
end

return M
