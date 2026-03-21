local M = {}

local SmoothTurn = require("utils.smooth_turn")
local which = require("utils.which")

if not which:is_module_exists("cmp") then
	return
end

local cmp = require("cmp")

local scroll = SmoothTurn:new(
	function()
		return cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select, count = 1 })
	end,
	function()
		return cmp.select_next_item({ behavior = cmp.SelectBehavior.Select, count = 1 })
	end,
	3, -- max_steps
	25 -- interval мс
)

M.scroll_up = function()
	scroll:start(true)
end
M.scroll_down = function()
	scroll:start(false)
end

return M
