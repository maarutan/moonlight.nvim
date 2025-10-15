return {
	"nvim-tree/nvim-web-devicons",
	opts = {
		override = {
			zsh = { icon = "", color = "#428850", name = "Zsh" },
			lua = { icon = "", color = "#51AFEF", name = "Lua" },
			css = { icon = "", color = "#318CCA", name = "Css" },
			html = { icon = "", color = "#F16A30", name = "Html" },
			javascript = { icon = "", color = "#F7DF1E", name = "Js" },
			py = { icon = "", color = "#F7DF1E", name = "Python" },
			typescriptxml = { icon = "", color = "#087ECE", name = "Tsx" },
			javascriptxml = { icon = "", color = "#08D9FF", name = "Jsx" },
			readme = { icon = "󰂺", color = "#ffffff", name = "Readme" },
		},
		override_by_filename = {
			[".config"] = { icon = "", cterm_color = "111", name = "Config" },
			["css.map"] = { icon = "", color = "#318CCA", name = "Map" },
			[".gitignore"] = { icon = "", color = "#f1502f", name = "Gitignore" },
			[".venv"] = { icon = "", color = "", name = "Venv" },
			[".python-version"] = { icon = "", color = "#89B4FB", name = "python-version" },
			["requirements.txt"] = { icon = "󱁻", color = "#89B4FB", name = "requirements.txt" },
			[".tridactylrc"] = { icon = "󰏩", color = "#428850", name = "tridactylrc" },
		},
	},
}
