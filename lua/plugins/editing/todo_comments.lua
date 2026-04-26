local const = require("utils.constants")

return {
	"folke/todo-comments.nvim",

	version = "*",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		signs = true,
		sign_priority = 8,
		keywords = {
			FIX = {
				icon = const.icons.diagnostic.debug .. " ",
				color = "error",
				alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
			},
			DONE = { icon = const.icons.diagnostic.done .. " ", color = "info" },
			TODO = { icon = const.icons.diagnostic.done .. " ", color = "info" },
			HACK = { icon = const.icons.diagnostic.hack .. " ", color = "warning" },
			WARN = {
				icon = const.icons.diagnostic.warn .. " ",
				color = "warning",
				alt = { "WARNING", "XXX" },
			},
			PERF = {
				icon = const.icons.diagnostic.perf .. " ",
				alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" },
			},
			NOTE = { icon = const.icons.diagnostic.info .. " ", color = "hint", alt = { "INFO" } },
			TEST = {
				icon = const.icons.diagnostic.test .. " ",
				color = "test",
				alt = { "TESTING", "PASSED", "FAILED" },
			},
		},
		gui_style = {
			fg = "NONE",
			bg = "BOLD",
		},
		merge_keywords = true,
		highlight = {
			multiline = true,
			before = "",
			keyword = "wide",
			after = "fg",
			pattern = [[.*<(KEYWORDS)\s*:]],
			comments_only = true,
			max_line_len = 400,
			exclude = {},
		},
		colors = {
			error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
			warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
			info = { "DiagnosticInfo", "#2563EB" },
			hint = { "DiagnosticHint", "#10B981" },
			default = { "Identifier", "#7C3AED" },
			test = { "Identifier", "#FF00FF" },
		},
		search = {
			command = "rg",
			args = {
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
			},
			pattern = [[\b(KEYWORDS):]],
		},
	},
}
