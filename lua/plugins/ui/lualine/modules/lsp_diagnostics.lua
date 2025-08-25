local signs = require("core.options").signs
return {
	"diagnostics",
	colored = true,
	sources = { "nvim_diagnostic" },
	symbols = {
		error = " " .. signs.error .. " ",
		warn = " " .. signs.warn .. " ",
		info = " " .. signs.info .. " ",
		hint = " " .. signs.hint .. " ",
	},
}
