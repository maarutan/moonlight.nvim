---@diagnostic disable: undefined-global
local r = require
local d = "plugins.snacks.modules."

---@diagnostic disable: undefined-doc-name
return {
	"folke/snacks.nvim",
	enabled = true,
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- scroll = r(d .. "scroll"),
		dashboard = r(d .. "dashboard"),
		indent = r(d .. "indent"),
		input = r(d .. "input"),
		notifier = r(d .. "notifier"),
		styles = r(d .. "styles"),
		image = r(d .. "image"),
		picker = r(d .. "picker"),
	},
}
