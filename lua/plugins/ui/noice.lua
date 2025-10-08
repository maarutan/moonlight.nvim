local border = "rounded"
-- lazy.nvim
return {
	"folke/noice.nvim",
	enabled = true,
	event = "VeryLazy",
	version = "*", -- use latest release
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
		-- OPTIONAL:
		--   `nvim-notify` is only needed, if you want to use the notification view.
		--   If not available, we use `mini` as the fallback
		-- "rcarriga/nvim-notify",
	},
	opts = {
		lsp = {
			signature = { opts = { size = { max_height = 10, max_width = 60 }, border = border } },
			hover = { opts = { size = { max_height = 20, max_width = 60 }, border = border } },
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},

		cmdline = {
			enabled = true,
			format = {
				-- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
				-- view: (default is cmdline view)
				-- opts: any options passed to the view
				-- icon_hl_group: optional hl_group for the icon
				-- title: set to anything or empty string to hide
				cmdline = { pattern = "^:", icon = "", lang = "vim" },
				search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
				search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
				filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
				lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
				help = { pattern = "^:%s*he?l?p?%s+", icon = "?" },
				input = { view = "cmdline_input", icon = "" }, -- Used by input()
				-- lua = false, -- to disable a format, set to `false`
			},
		},
		--- lazy ---
		-- presets = {
		-- 	bottom_search = true, -- use a classic bottom cmdline for search
		-- 	command_palette = true, -- position the cmdline and popupmenu together
		-- 	long_message_to_split = true, -- long messages will be sent to a split
		-- 	inc_rename = false, -- enables an input dialog for inc-rename.nvim
		-- 	lsp_doc_border = false, -- add a border to hover docs and signature help
		-- },
		--- lazy ---

		progress = {},

		routes = {
			{
				filter = {
					event = "msg_show",
					any = {
						{ find = "%d+L, %d+B" },
						{ find = "; after #%d+" },
						{ find = "; before #%d+" },
					},
				},
				view = "mini",
			},
		},

		views = {
			cmdline_input = {
				border = {
					style = border,
				},
			},
			cmdline_popup = {
				border = {
					style = border,
					-- padding = { 1, 1 },
				},
				position = {
					row = "37%",
					col = "50%",
				},
				size = {
					width = 60,
					height = "auto",
				},
			},
			mini = {
				position = {
					row = "97%",
					col = "100%",
				},
				size = {
					width = "auto",
					height = "auto",
				},
			},
		},
	},
}
