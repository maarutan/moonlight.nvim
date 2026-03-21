-- return {}
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,

	---@type snacks.Config
	opts = {
		dashboard = require("plugins.snacks.modules.dashboard"),
		input = require("plugins.snacks.modules.input"),
		notifier = require("plugins.snacks.modules.notifier"),
		styles = require("plugins.snacks.modules.styles"),
		image = require("plugins.snacks.modules.image"),
		picker = require("plugins.snacks.modules.picker"),
	},
}
