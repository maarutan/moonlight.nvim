local const = require("utils.constants")

return {
	"lsp_status",
	icon = const.icons.ui.gears .. "  LSP:",
	color = { fg = "#ffffff", gui = "bold" },
	symbols = {
		spinner = {
			const.icons.ui.spinner.f1,
			const.icons.ui.spinner.f2,
			const.icons.ui.spinner.f3,
			const.icons.ui.spinner.f4,
			const.icons.ui.spinner.f5,
			const.icons.ui.spinner.f6,
			const.icons.ui.spinner.f7,
			const.icons.ui.spinner.f8,
			const.icons.ui.spinner.f9,
			const.icons.ui.spinner.f10,
		},
		done = const.icons.diagnostic.done,
	},
}
