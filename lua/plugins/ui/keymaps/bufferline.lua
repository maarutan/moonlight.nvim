local icons = require("utils.constants.icons")
local which = require("utils.which")

local Snacks
if which:is_module_exists("snacks") then
	Snacks = require("snacks")
end

return {
	{
		"<A-1>",
		"<cmd>BufferLineGoToBuffer 1<cr>",
		desc = "Go to buffer 1",
		mode = { "n", "v", "x", "i" },
		icon = { icon = icons.ui.buffer },
	},
	{
		"<A-2>",
		"<cmd>BufferLineGoToBuffer 2<cr>",
		desc = "Go to buffer 2",
		mode = { "n", "v", "x", "i" },
		icon = { icon = icons.ui.buffer },
	},
	{
		"<A-3>",
		"<cmd>BufferLineGoToBuffer 3<cr>",
		desc = "Go to buffer 3",
		mode = { "n", "v", "x", "i" },
		icon = { icon = icons.ui.buffer },
	},
	{
		"<A-4>",
		"<cmd>BufferLineGoToBuffer 4<cr>",
		desc = "Go to buffer 4",
		mode = { "n", "v", "x", "i" },
		icon = { icon = icons.ui.buffer },
	},
	{
		"<A-5>",
		"<cmd>BufferLineGoToBuffer 5<cr>",
		desc = "Go to buffer 5",
		mode = { "n", "v", "x", "i" },
		icon = { icon = icons.ui.buffer },
	},
	{
		"<A-6>",
		"<cmd>BufferLineGoToBuffer 6<cr>",
		desc = "Go to buffer 6",
		mode = { "n", "v", "x", "i" },
		icon = { icon = icons.ui.buffer },
	},
	{
		"<A-7>",
		"<cmd>BufferLineGoToBuffer 7<cr>",
		desc = "Go to buffer 7",
		mode = { "n", "v", "x", "i" },
		icon = { icon = icons.ui.buffer },
	},
	{
		"<A-8>",
		"<cmd>BufferLineGoToBuffer 8<cr>",
		desc = "Go to buffer 8",
		mode = { "n", "v", "x", "i" },
		icon = { icon = icons.ui.buffer },
	},
	{
		"<A-9>",
		"<cmd>BufferLineGoToBuffer 9<cr>",
		desc = "Go to buffer 9",
		mode = { "n", "v", "x", "i" },
		icon = { icon = icons.ui.buffer },
	},

	{
		"<S-j>",
		"<cmd>BufferLineCycleNext<cr>",
		desc = "Next Buffer ",
		mode = { "n" },
		icon = { icon = icons.ui.buffer },
	},
	{
		"<S-k>",
		"<cmd>BufferLineCyclePrev<cr>",
		desc = "Previous Buffer",
		mode = { "n" },
		icon = { icon = icons.ui.buffer },
	},

	{
		"<S-A-j>",
		"<cmd>BufferLineMoveNext<cr>",
		desc = "Next Buffer ",
		mode = { "n" },
		icon = { icon = icons.ui.buffer },
	},
	{
		"<S-A-k>",
		"<cmd>BufferLineMovePrev<cr>",
		desc = "Previous Buffer",
		mode = { "n" },
		icon = { icon = icons.ui.buffer },
	},

	{
		"<leader>br",
		function()
			Snacks.rename.rename_file()
		end,
		icon = { icon = icons.ui.buffer },
		desc = "Buffer Rename",
		mode = { "n" },
	},
	{
		"<C-w>f",
		function()
			local wins = vim.api.nvim_list_wins()
			local floating_wins = {}

			for _, win in ipairs(wins) do
				local config = vim.api.nvim_win_get_config(win)
				if config.relative and config.relative ~= "" then
					table.insert(floating_wins, win)
				end
			end

			if #floating_wins == 0 then
				print("No floating windows found")
				return
			end

			local current = vim.api.nvim_get_current_win()
			local start_idx = 0

			for i, win in ipairs(floating_wins) do
				if win == current then
					start_idx = i
					break
				end
			end

			local next_idx = (start_idx % #floating_wins) + 1

			vim.api.nvim_set_current_win(floating_wins[next_idx])
		end,
		desc = "Next Floating Window",
		mode = { "n" },
		icon = { icon = icons.ui.buffer },
	},
	{
		"<leader>bP",
		"<cmd>BufferLineTogglePin<cr>",
		desc = "Pin Buffer",
		mode = { "n" },
		icon = { icon = icons.ui.buffer },
	},
	{
		"<leader>bp",
		"<cmd>BufferLinePick<cr>",
		desc = "Pick Buffer",
		mode = { "n" },
		icon = { icon = icons.ui.buffer },
	},

	{
		"<leader>bC",
		group = "Copy Buffers",
		mode = { "n" },
		icon = { icon = icons.ui.buffer },
	},
	{
		"<leader>bCp",
		function()
			local path = vim.api.nvim_buf_get_name(0)
			vim.fn.setreg("+", path)
		end,
		desc = "Copy Path",
		mode = { "n" },
		icon = { icon = icons.ui.buffer },
	},
	{
		"<leader>bCf",
		function()
			local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
			vim.fn.setreg("+", path)
		end,
		desc = "Copy Filename",
		mode = { "n" },
		icon = { icon = icons.ui.buffer },
	},
	{
		"<leader>bCw",
		function()
			local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t:r")
			vim.fn.setreg("+", path)
		end,
		desc = "Copy Filename without extension",
		mode = { "n" },
		icon = { icon = icons.ui.buffer },
	},
	{
		"<leader>bCe",
		function()
			local home = os.getenv("HOME") or os.getenv("USERPROFILE") or ""
			local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")

			if path:find(home, 1, true) then
				path = path:gsub("^" .. vim.pesc(home), "~")
			end

			vim.fn.setreg("+", path)
		end,
		desc = "Copy Expand Path",
		mode = { "n" },
		icon = { icon = icons.ui.buffer },
	},

	{
		"<leader>bs",
		group = "Sort Buffers",
		mode = { "n" },
		icon = { icon = icons.ui.buffer },
	},
	{
		"<leader>bsr",
		"<cmd>BufferLineSortByRelativeDirectory<cr>",
		desc = "Sort By Relative Directory",
		mode = { "n" },
		icon = { icon = icons.ui.buffer },
	},
	{
		"<leader>bsd",
		"<cmd>BufferLineSortByDirectory<cr>",
		desc = "Sort By Directory",
		mode = { "n" },
		icon = { icon = icons.ui.buffer },
	},
	{
		"<leader>bst",
		"<cmd>BufferLineSortByTabs<cr>",
		desc = "Sort By Tabs",
		mode = { "n" },
		icon = { icon = icons.ui.buffer },
	},
	{
		"<leader>bse",
		"<cmd>BufferLineSortByExtension<cr>",
		desc = "Sort By Extension",
		mode = { "n" },
		icon = { icon = icons.ui.buffer },
	},

	{
		"<leader>bc",
		group = "Close the Buffers",
		mode = { "n" },
		icon = { icon = icons.ui.buffer },
	},
	{
		"<leader>bcl",
		"<cmd>BufferLineCloseLeft<cr>",
		desc = "Close the Buffer left",
		mode = { "n" },
		icon = { icon = icons.ui.buffer },
	},
	{
		"<leader>bch",
		"<cmd>BufferLineCloseRight<cr>",
		desc = "Close the Buffer right",
		mode = { "n" },
		icon = { icon = icons.ui.buffer },
	},
	{
		"<leader>bco",
		"<cmd>BufferLineCloseOthers<cr>",
		desc = "Close the Buffer others",
		mode = { "n" },
		icon = { icon = icons.ui.buffer },
	},
	{
		"<leader>bcp",
		"<cmd>BufferLinePickClose<cr>",
		desc = "Close the Buffer picked",
		mode = { "n" },
		icon = { icon = icons.ui.buffer },
	},

	{
		"<leader>bg",
		group = "Group Buffers",
		mode = { "n" },
		icon = { icon = icons.ui.buffer },
	},
	{
		"<leader>bgt",
		"<cmd>BufferLineGroupToggle<cr>",
		desc = "Toggle the Buffer group",
		mode = { "n" },
		icon = { icon = icons.ui.buffer },
	},
	{
		"<leader>bgc",
		"<cmd>BufferLineGroupClose<cr>",
		desc = "Close the Buffer group",
		mode = { "n" },
		icon = { icon = icons.ui.buffer },
	},
}
