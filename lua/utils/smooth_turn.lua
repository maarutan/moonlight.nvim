---@class SmoothTurn
---@field up_fn     fun():boolean         # функция прокрутки вверх
---@field down_fn   fun():boolean         # функция прокрутки вниз
---@field max_steps integer               # кол-во шагов
---@field interval  integer               # задержка между шагами (мс)
---@field timer     uv_timer_t|nil        # таймер libuv
---@field counter   integer               # текущий шаг
local SmoothTurn = {}
SmoothTurn.__index = SmoothTurn

--- Создать новый скроллер
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

--- Один шаг прокрутки
---@param is_up boolean
---@return boolean ok
function SmoothTurn:_step(is_up) return (is_up and self.up_fn() or self.down_fn()) end

--- Запустить плавную прокрутку
---@param is_up boolean
function SmoothTurn:start(is_up)
	self:stop()
	-- если таймер уже есть — останавливаем
	if self.timer then
		self.timer:stop()
		self.timer:close()
		self.timer = nil
	end

	self.counter = 0
	self.timer = vim.loop.new_timer()

	self.timer:start(
		0, -- первый вызов сразу
		self.interval, -- далее каждые interval мс
		vim.schedule_wrap(function()
			self.counter = self.counter + 1
			local ok = self:_step(is_up)

			if not ok or self.counter >= self.max_steps then self:stop() end
		end)
	)
end

--- Остановить прокрутку
function SmoothTurn:stop()
	if self.timer then
		self.timer:stop()
		self.timer:close()
		self.timer = nil
	end
end

return SmoothTurn
