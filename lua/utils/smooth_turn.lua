---@class SmoothTurn
---@field up_fn     fun():boolean
---@field down_fn   fun():boolean
---@field max_steps integer
---@field interval  integer
---@field timer     uv_timer_t|nil
---@field counter   integer
local SmoothTurn = {}
SmoothTurn.__index = SmoothTurn

---@param up_fn    fun():boolean
---@param down_fn  fun():boolean
---@param max_steps? integer
---@param interval?  integer
---@return SmoothTurn
function SmoothTurn:new(up_fn, down_fn, max_steps, interval)
	local obj = setmetatable({}, self)
	obj.up_fn = up_fn
	obj.down_fn = down_fn
	obj.max_steps = max_steps or 4
	obj.interval = interval or 30
	obj.timer = nil
	obj.counter = 0
	return obj
end

---@param is_up boolean
---@return boolean ok
function SmoothTurn:_step(is_up)
	return (is_up and self.up_fn() or self.down_fn())
end

---@param is_up boolean
function SmoothTurn:start(is_up)
	self:stop()
	if self.timer then
		self.timer:stop()
		self.timer:close()
		self.timer = nil
	end

	self.counter = 0
	self.timer = vim.loop.new_timer()

	self.timer:start(
		0,
		self.interval,
		vim.schedule_wrap(function()
			self.counter = self.counter + 1
			local ok = self:_step(is_up)

			if not ok or self.counter >= self.max_steps then
				self:stop()
			end
		end)
	)
end

function SmoothTurn:stop()
	if self.timer then
		self.timer:stop()
		self.timer:close()
		self.timer = nil
	end
end

return SmoothTurn
