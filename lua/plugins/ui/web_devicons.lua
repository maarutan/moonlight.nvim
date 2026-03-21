local const = require("utils.constants")
local files = const.icons.web_icons.files
local dirs = const.icons.web_icons.directories

return {
	"nvim-tree/nvim-web-devicons",
	opts = {
		override = {
			zsh = { icon = files.zsh, color = "#428850", name = "Zsh" },
			lua = { icon = files.lua, color = "#51AFEF", name = "Lua" },
			css = { icon = files.css, color = "#318CCA", name = "Css" },
			html = { icon = files.html, color = "#F16A30", name = "Html" },
			javascript = { icon = files.javascript, color = "#F7DF1E", name = "Js" },
			py = { icon = files.py, color = "#F7DF1E", name = "Python" },
			typescriptxml = { icon = files.typescriptxml, color = "#087ECE", name = "Tsx" },
			javascriptxml = { icon = files.javascriptxml, color = "#08D9FF", name = "Jsx" },
			readme = { icon = files.readme, color = "#ffffff", name = "Readme" },
		},

		override_by_filename = {
			["css.map"] = { icon = files["css.map"], color = "#318CCA", name = "Map" },
			[".gitignore"] = { icon = files.git, color = "#f1502f", name = "Gitignore" },
			[".python-version"] = { icon = files.python, color = "#89B4FB", name = "python-version" },
			["requirements.txt"] = { icon = files.configtxt, color = "#89B4FB", name = "requirements.txt" },
			[".tridactylrc"] = { icon = files.paw, color = "#428850", name = "tridactylrc" },
		},
	},
}
