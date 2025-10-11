local r = require
local SmoothTurn = r("utils.smooth_turn")

local M = {}

M.picker = {
	scroll_handler = function(picker, is_up)
		local scroll = SmoothTurn:new(
			function()
				Snacks.picker.actions.list_up(picker)
				return true
			end,
			function()
				Snacks.picker.actions.list_down(picker)
				return true
			end,
			4, -- max_steps
			30 -- interval (ms)
		)
		scroll:start(is_up)
	end,

	scroll_to_handle = function(picker, is_top, steps)
		if steps and steps <= 300 then
			local scroll = SmoothTurn:new(function()
				Snacks.picker.actions.list_up(picker)
				return true
			end, function()
				Snacks.picker.actions.list_down(picker)
				return true
			end, steps, 4)
			scroll:start(is_top)
		else
			if is_top then
				Snacks.picker.actions.list_top(picker)
			else
				Snacks.picker.actions.list_bottom(picker)
			end
		end
	end,
}

return M
