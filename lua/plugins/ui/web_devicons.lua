require("nvim-web-devicons").setup({
	override = {
		zsh = { icon = "", color = "#428850", cterm_color = "65", name = "Zsh" },
		lua = { icon = "", color = "#51AFEF", cterm_color = "111", name = "Lua" },
	},
	override_by_filename = {
		[".config"] = { icon = "", cterm_color = "111", name = "Config" },
		[".gitignore"] = { icon = "", color = "#f1502f", name = "Gitignore" },
	},
})
