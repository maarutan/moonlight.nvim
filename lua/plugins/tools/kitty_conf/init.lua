local which = require("utils.which")

local M = {}

if not which:is_exists("kitty") then
	return
end

local icons = require("utils.constants.icons")
local kitty_api = require("plugins.tools.kitty_conf.kitty_api")
local font_management = require("plugins.tools.kitty_conf.font_management")
local notify_status = require("plugins.tools.kitty_conf.notify_status")
local picker_preview = require("plugins.tools.kitty_conf.picker_preview")
-- local Snacks = require("snacks")

function M.setup()
	kitty_api.kitty_config_startup()
end

function M.pick_font()
	local before_state = kitty_api.get_state()
	local before_font = before_state.current_font or before_state.font
	local confirmed = false

	Snacks.picker.pick({
		title = icons.ui.kitty .. " Font Selector",
		items = vim.tbl_map(function(font)
			return { text = font }
		end, font_management.list_fonts_unique()),
		format = "text",
		preview = function(ctx)
			picker_preview(ctx, before_state)
		end,
		confirm = function(picker, item)
			confirmed = true
			picker:close()

			if item and item.text then
				kitty_api.set_font(item.text)
			end
		end,
		on_close = function()
			if not confirmed and before_font and before_font ~= "---" then
				kitty_api.set_font(before_font)
			end
		end,
	})
end

function M.input_font_size()
	vim.ui.input({ prompt = icons.ui.kitty .. " kitty font size: " }, function(input)
		if not input or input == "" then
			return
		end

		local size = tonumber(input)
		if not size or size <= 0 then
			vim.notify("Invalid kitty font size", vim.log.levels.WARN)
			return
		end

		kitty_api.set_size(size)
	end)
end

function M.reload()
	kitty_api.reload_kitty()
	kitty_api.kitty_config_startup()
end

function M.increase_font_size()
	kitty_api.increase_font_size()
end

function M.decrease_font_size()
	kitty_api.decrease_font_size()
end

function M.notify_status()
	notify_status.notify()
end

return M
