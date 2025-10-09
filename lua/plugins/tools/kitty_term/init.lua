local r = require
local d = "plugins.tools.kitty_term."
local core = r(d .. "core")
local json = r("utils.json")
local config = r(d .. "config")
local prev = r(d .. "preview")
local icons = r("utils.icons")

local M = {}

M.core = core

local path_config = vim.fn.stdpath("config") .. "/" .. config.setup.config_path

-- Start logic on load
function M.start() core.autostart() end

function M.pick()
	local fonts = core.list_fonts_unique()
	local last_item = json.load(path_config) or {}

	Snacks.picker.pick({
		title = icons.kitty.title .. " Font Selector",
		items = vim.tbl_map(function(f) return { text = f } end, fonts),
		format = "text",

		preview = function(ctx) prev.font_preview(ctx, last_item) end,

		confirm = function(picker, item)
			picker:close()
			if item then
				json.save(path_config, { font = item.text }, 2)
				core.set_font(item.text)
			end
		end,
	})
end

function M.size()
	vim.ui.input({ prompt = icons.kitty.title .. " kitty font size:" }, function(input)
		if input == "" or input == "0" or input == nil or input == false then
			return
		else
			json.update(path_config, { size = input }, 2)
			core.set_size(input)
		end
	end)
end

function M.reload()
	core.restore_original_font()
	core.autostart()
end

function M.plus()
	print("plus kitty font")
	core.increase_font_size()
	core.reload_kitty()
end

function M.minus()
	print("minus kitty font")
	core.decrease_font_size()
	core.reload_kitty()
end

M.status = function() r(d .. "status").status() end
M.lazy = r(d .. "kitty_scrollback")

return M
