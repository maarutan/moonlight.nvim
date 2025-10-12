local border = "rounded"

return {
	"folke/noice.nvim",
	enabled = true,
	event = "VeryLazy",
	version = "*",
	dependencies = { "MunifTanjim/nui.nvim" },
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
				cmdline = { pattern = "^:", icon = "", lang = "vim" },
				search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
				search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
				filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
				lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
				help = { pattern = "^:%s*he?l?p?%s+", icon = "?" },
				input = { view = "cmdline_input", icon = "" },
			},
		},
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
			cmdline_input = { border = { style = border } },
			cmdline_popup = {
				border = { style = border },
				position = { row = "37%", col = "50%" },
				size = { width = 60, height = "auto" },
			},
			mini = {
				position = { row = "97%", col = "100%" },
				size = { width = "auto", height = "auto" },
			},
		},
	},
	config = function(_, opts)
		require("noice").setup(opts)

		local grp = vim.api.nvim_create_augroup("NoiceBackdrop", { clear = true })

		local function open_backdrop()
			if vim.g._noice_backdrop_win and vim.api.nvim_win_is_valid(vim.g._noice_backdrop_win) then return end
			local buf = vim.api.nvim_create_buf(false, true)
			local win = vim.api.nvim_open_win(buf, false, {
				relative = "editor",
				width = vim.o.columns,
				height = vim.o.lines,
				row = 0,
				col = 0,
				style = "minimal",
				focusable = false,
				zindex = 50,
				noautocmd = true,
			})
			if vim.fn.hlexists("NoiceBackdrop") == 0 then vim.api.nvim_set_hl(0, "NoiceBackdrop", { bg = "#000000" }) end
			vim.api.nvim_win_set_option(win, "winhighlight", "Normal:NoiceBackdrop")
			pcall(vim.api.nvim_win_set_option, win, "winblend", 70)
			vim.g._noice_backdrop_win = win
		end

		local function close_backdrop()
			local win = vim.g._noice_backdrop_win
			if win and vim.api.nvim_win_is_valid(win) then pcall(vim.api.nvim_win_close, win, true) end
			vim.g._noice_backdrop_win = nil
		end

		vim.api.nvim_create_autocmd("CmdlineEnter", { group = grp, callback = open_backdrop })
		vim.api.nvim_create_autocmd("CmdlineLeave", { group = grp, callback = close_backdrop })
		vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
			group = grp,
			callback = function()
				if vim.fn.mode():find("c") then return end
				close_backdrop()
			end,
		})
	end,
}
