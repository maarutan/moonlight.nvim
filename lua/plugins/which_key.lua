---@diagnostic disable: undefined-global
local r = require
local ui = r("utils.ui")
local user = r("utils.whoami")
local icons = r("utils.icons")
local terminal = r("utils.terminal")
local kitty = r("plugins.tools.kitty_term")
local toggle_word = r("plugins.tools.toggle_word")

return {
	"folke/which-key.nvim",
	enabled = true,
	event = "VeryLazy",
	dependencies = "echasnovski/mini.icons",
	opts = {
		preset = "modern",
		win = { border = ui.border },
	},
	config = function(_, opts)
		local wk = r("which-key")
		wk.setup(opts)

		-- Base mappings
		local mappings = {

			-- Neo-tree
			{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Neotree", icon = { icon = icons.neotree } },

			-- Picker (Snacks)
			{ "<leader>f", group = "Find", icon = { icon = icons.find } },
			{
				"<leader>ff",
				function() Snacks.picker.files() end,
				icon = { icon = icons.find },
				desc = "Find File",
			},
			{
				"<leader>fw",
				function() Snacks.picker.grep_word() end,
				icon = { icon = icons.find },
				desc = "Find Word Under Cursor",
			},
			{
				"<leader>fu",
				function() Snacks.picker.undo() end,
				icon = { icon = icons.find },
				desc = "Find Undo",
			},
			{
				"<leader>fW",
				function() Snacks.picker.grep() end,
				icon = { icon = icons.find },
				desc = "Find Word",
			},
			{
				"<leader>fb",
				function() Snacks.picker.buffers() end,
				icon = { icon = icons.find },
				desc = "Find Buffer",
			},
			{
				"<leader>fh",
				function() Snacks.picker.help() end,
				icon = { icon = icons.find },
				desc = "Find Help",
			},
			{
				"<leader>fH",
				function() Snacks.picker.health() end,
				icon = { icon = icons.find },
				desc = "Find Health",
			},
			{
				"<leader>fr",
				function() Snacks.picker.recent() end,
				icon = { icon = icons.find },
				desc = "Find Recent",
			},
			{
				"<leader>fR",
				function() Snacks.picker.recent({ filter = { cwd = true }, confirm = { "edit", "tcd" } }) end,
				icon = { icon = icons.find },
				desc = "Recent in CWD & cd",
			},
			{
				"<leader>fm",
				function() Snacks.picker.keymaps() end,
				icon = { icon = icons.find },
				desc = "Find Mappings",
			},
			{
				"<leader>fc",
				function() Snacks.picker.colorschemes() end,
				desc = "Find Colorscheme",
				icon = { icon = icons.color },
			},

			-- Notifications
			{ "<leader>n", group = "Notifications", icon = { icon = icons.notification } },
			{
				"<leader>nu",
				function() Snacks.notifier.hide() end,
				desc = "Hide Notifications",
			},
			{
				"<leader>nh",
				function() Snacks.notifier.show_history() end,
				desc = "Show Notification History",
			},
			{
				"<leader>nt",
				function() vim.notify("This is a test " .. user .. " !!!", vim.log.levels.WARN, { title = "Demo", icon = "⚠️" }) end,
				desc = "Test Notification",
			},

			-- Comments + CCC
			{ "<leader>c", group = "Comment + Ccc", mode = "n", icon = { icon = icons.comments.group } },
			{ "<leader>c", group = "Comment", mode = "x", icon = { icon = icons.comments.group } },
			{ "<leader>cl", "<Plug>(comment_toggle_linewise_current)", desc = "Comment Line", mode = "n" },
			{ "<leader>cb", "<Plug>(comment_toggle_blockwise_current)", desc = "Comment Block", mode = "n" },
			{ "<leader>cl", "<Plug>(comment_toggle_linewise_visual)", desc = "Comment Line (Visual)", mode = "x" },
			{ "<leader>cb", "<Plug>(comment_toggle_blockwise_visual)", desc = "Comment Block (Visual)", mode = "x" },

			-- CCC
			{ "<leader>cc", group = "CCC", icon = { icon = icons.color } },
			{ "<leader>ccp", "<cmd>CccPick<cr>", desc = "CCC Pick" },
			{ "<leader>ccc", "<cmd>CccConvert<cr>", desc = "CCC Convert" },

			-- Hop
			{ "<leader>h", group = "Hop", icon = { icon = icons.hop } },
			{ "<leader>hw", "<cmd>HopWord<cr>", desc = "Hop Word" },
			{ "<leader>hl", "<cmd>HopLine<cr>", desc = "Hop Line" },
			{ "<leader>hf", "<cmd>HopAnywhereMW<cr>", desc = "Hop Anywhere" },

			-- Terminal
			{ "<leader>t", group = "Terminal", icon = { icon = icons.terminal } },
			{ "<leader>tt", "<cmd>ToggleTerm direction=tab<cr>", desc = "Terminal New Tab" },
			{ "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Terminal Float" },
			{ "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Terminal Vertical" },
			{ "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Terminal Horizontal" },
			{ "<C-t>", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },

			-- Trouble (Workspace)
			{ "<leader>x", group = "Trouble", icon = { icon = icons.menu } },
			{ "<leader>xd", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Project)" },
			{ "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Diagnostics (Buffer)" },
			{ "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols" },
			{
				"<leader>xl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions/Refs",
			},
			{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List" },
			{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List" },

			-- GoVSM
			{ "<A-h>", "V<Plug>GoVSMLeft<Esc>", desc = "Move line ←", mode = "n" },
			{ "<A-j>", "V<Plug>GoVSMDown<Esc>", desc = "Move line ↓", mode = "n" },
			{ "<A-k>", "V<Plug>GoVSMUp<Esc>", desc = "Move line ↑", mode = "n" },
			{ "<A-l>", "V<Plug>GoVSMRight<Esc>", desc = "Move line →", mode = "n" },

			{ "<A-h>", "<Plug>GoVSMLeft", desc = "Move selection ←", mode = "v" },
			{ "<A-j>", "<Plug>GoVSMDown", desc = "Move selection ↓", mode = "v" },
			{ "<A-k>", "<Plug>GoVSMUp", desc = "Move selection ↑", mode = "v" },
			{ "<A-l>", "<Plug>GoVSMRight", desc = "Move selection →", mode = "v" },

			{ "<A-S-C-h>", "<Plug>GoNSDLeft", desc = "Duplicate ←", mode = "n" },
			{ "<A-S-C-j>", "<Plug>GoNSDDown", desc = "Duplicate ↓", mode = "n" },
			{ "<A-S-C-k>", "<Plug>GoNSDUp", desc = "Duplicate ↑", mode = "n" },
			{ "<A-S-C-l>", "<Plug>GoNSDRight", desc = "Duplicate →", mode = "n" },

			{ "<A-S-C-h>", "<Plug>GoVSDLeft", desc = "Duplicate selection ←", mode = "x" },
			{ "<A-S-C-j>", "<Plug>GoVSDDown", desc = "Duplicate selection ↓", mode = "x" },
			{ "<A-S-C-k>", "<Plug>GoVSDUp", desc = "Duplicate selection ↑", mode = "x" },
			{ "<A-S-C-l>", "<Plug>GoVSDRight", desc = "Duplicate selection →", mode = "x" },

			-- Buffers
			-- Bufferline
			{ "<A-1>", "<cmd>BufferLineGoToBuffer 1<cr>", desc = "Go to buffer 1", mode = { "n", "v", "x", "i" } },
			{ "<A-2>", "<cmd>BufferLineGoToBuffer 2<cr>", desc = "Go to buffer 2", mode = { "n", "v", "x", "i" } },
			{ "<A-3>", "<cmd>BufferLineGoToBuffer 3<cr>", desc = "Go to buffer 3", mode = { "n", "v", "x", "i" } },
			{ "<A-4>", "<cmd>BufferLineGoToBuffer 4<cr>", desc = "Go to buffer 4", mode = { "n", "v", "x", "i" } },
			{ "<A-5>", "<cmd>BufferLineGoToBuffer 5<cr>", desc = "Go to buffer 5", mode = { "n", "v", "x", "i" } },
			{ "<A-6>", "<cmd>BufferLineGoToBuffer 6<cr>", desc = "Go to buffer 6", mode = { "n", "v", "x", "i" } },
			{ "<A-7>", "<cmd>BufferLineGoToBuffer 7<cr>", desc = "Go to buffer 7", mode = { "n", "v", "x", "i" } },
			{ "<A-8>", "<cmd>BufferLineGoToBuffer 8<cr>", desc = "Go to buffer 8", mode = { "n", "v", "x", "i" } },
			{ "<A-9>", "<cmd>BufferLineGoToBuffer 9<cr>", desc = "Go to buffer 9", mode = { "n", "v", "x", "i" } },

			{ "<S-j>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer ", mode = { "n" } },
			{ "<S-k>", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous Buffer", mode = { "n" } },

			{ "<S-A-j>", "<cmd>BufferLineMoveNext<cr>", desc = "Next Buffer ", mode = { "n" } },
			{ "<S-A-k>", "<cmd>BufferLineMovePrev<cr>", desc = "Previous Buffer", mode = { "n" } },

			{ "<leader>b", group = "Buffers", icon = { icon = icons.buffer } },
			{ "<leader>bd", "<cmd>Bdelete<cr>", icon = { icon = icons.buffer }, desc = "Delete Buffer" },
			{
				"<leader>bP",
				"<cmd>BufferLineTogglePin<cr>",
				icon = { icon = icons.buffer },
				desc = "Pin Buffer",
				mode = { "n" },
			},
			{
				"<leader>bp",
				"<cmd>BufferLinePick<cr>",
				icon = { icon = icons.buffer },
				desc = "Pick Buffer",
				mode = { "n" },
			},

			{ "<leader>bs", group = "Sort Buffers", icon = { icon = icons.buffer }, mode = { "n" } },
			{
				"<leader>bsr",
				"<cmd>BufferLineSortByRelativeDirectory<cr>",
				icon = { icon = icons.buffer },
				desc = "Sort By Relative Directory",
				mode = { "n" },
			},
			{
				"<leader>bsd",
				"<cmd>BufferLineSortByDirectory<cr>",
				icon = { icon = icons.buffer },
				desc = "Sort By Directory",
				mode = { "n" },
			},
			{
				"<leader>bst",
				"<cmd>BufferLineSortByTabs<cr>",
				icon = { icon = icons.buffer },
				desc = "Sort By Tabs",
				mode = { "n" },
			},
			{
				"<leader>bse",
				"<cmd>BufferLineSortByExtension<cr>",
				icon = { icon = icons.buffer },
				desc = "Sort By Extension",
				mode = { "n" },
			},

			{ "<leader>bc", group = "Close the Buffers", icon = { icon = icons.buffer }, mode = { "n" } },
			{
				"<leader>bcl",
				"<cmd>BufferLineCloseLeft<cr>",
				icon = { icon = icons.buffer },
				desc = "Close the Buffer left",
				mode = { "n" },
			},
			{
				"<leader>bch",
				"<cmd>BufferLineCloseRight<cr>",
				icon = { icon = icons.buffer },
				desc = "Close the Buffer right",
				mode = { "n" },
			},
			{
				"<leader>bco",
				"<cmd>BufferLineCloseOthers<cr>",
				icon = { icon = icons.buffer },
				desc = "Close the Buffer others",
				mode = { "n" },
			},
			{
				"<leader>bcp",
				"<cmd>BufferLinePickClose<cr>",
				icon = { icon = icons.buffer },
				desc = "Close the Buffer picked",
				mode = { "n" },
			},

			{ "<leader>bg", group = "Group Buffers", icon = { icon = icons.buffer }, mode = { "n" } },
			{
				"<leader>bgt",
				"<cmd>BufferLineGroupToggle<cr>",
				icon = { icon = icons.buffer },
				desc = "Toggle the Buffer group",
				mode = { "n" },
			},
			{
				"<leader>bgc",
				"<cmd>BufferLineGroupClose<cr>",
				icon = { icon = icons.buffer },
				desc = "Close the Buffer group",
				mode = { "n" },
			},
			{ "<leader>l", group = "LSP", icon = { icon = icons.lsp } },

			-- ===== LSPsaga actions =====
			{
				"<leader>ld",
				"<cmd>Lspsaga goto_definition<CR>",
				desc = "Goto Definition",
				mode = { "n" },
			},
			{
				"<leader>lD",
				"<cmd>Lspsaga goto_type_definition<CR>",
				desc = "Goto Type Definition",
				mode = { "n" },
			},
			{
				"<leader>li",
				"<cmd>Lspsaga show_line_diagnostics<CR>",
				desc = "Line Diagnostics",
				mode = { "n" },
			},
			{
				"<leader>lr",
				"<cmd>Lspsaga rename<CR>",
				desc = "Rename Symbol",
				mode = { "n" },
			},
			{
				"<leader>lh",
				"<cmd>Lspsaga hover_doc<CR>",
				desc = "Hover Doc",
				mode = { "n" },
			},
			{
				"<leader>lo",
				"<cmd>Lspsaga outline<CR>",
				desc = "Symbols Outline",
				mode = { "n" },
			},
			{
				"<leader>la",
				"<cmd>Lspsaga code_action<CR>",
				desc = "Code Action",
				mode = { "n" },
			},

			-- ===== Diagnostics =====
			{
				"<leader>dw",
				"<cmd>Lspsaga show_workspace_diagnostics<CR>",
				desc = "Workspace Diagnostics",
				mode = { "n" },
			},
			{
				"<leader>dc",
				"<cmd>Lspsaga show_line_diagnostics<CR>",
				desc = "Current Line Diagnostics",
				mode = { "n" },
			},
			{
				"<leader>dl",
				"<cmd>Lspsaga diagnostic_jump_next<CR>",
				desc = "Next Diagnostic",
				mode = { "n" },
			},
			{
				"<leader>dh",
				"<cmd>Lspsaga diagnostic_jump_prev<CR>",
				desc = "Prev Diagnostic",
				mode = { "n" },
			},

			-- ===== LSP Control =====
			{ "<leader>lR", "<cmd>LspRestart<CR>", desc = "Restart LSP", mode = { "n" } },
			{ "<leader>lI", "<cmd>LspInfo<CR>", desc = "LSP Info", mode = { "n" } },
			{ "<leader>lS", "<cmd>LspStop<CR>", desc = "Stop LSP", mode = { "n" } },
			{ "<leader>ls", "<cmd>LspStart<CR>", desc = "Start LSP", mode = { "n" } },
			{ "<leader>lt", function() toggle_word.toggle_word() end, desc = "Toggle Word LSP", mode = { "n" } },

			-- Lazy Reload

			{ "<leader>L", group = "Lazy", icon = { icon = icons.lazy }, mode = { "n" } },
			{ "<leader>Lr", function() vim.api.nvim_feedkeys(":ReloadPlugin ", "n", false) end, icon = { icon = icons.lazy }, desc = "Lazy Reload", mode = { "n" } },
			{ "<leader>Ls", "<cmd>Lazy sync<cr>", icon = { icon = icons.lazy }, desc = "Lazy Sync", mode = { "n" } },
		}

		-- Add Kitty-specific mappings
		if terminal.is_kitty() then
			table.insert(mappings, { "<leader>k", group = "Kitty-config", icon = { icon = icons.kitty.group } })
			table.insert(mappings, { "<leader>ku", function() kitty.plus() end, desc = "Kitty Font +1" })
			table.insert(mappings, { "<leader>kd", function() kitty.minus() end, desc = "Kitty Font -1" })
			table.insert(mappings, { "<leader>kf", function() kitty.pick() end, desc = "kitty Font Picker" })
			table.insert(mappings, { "<leader>ks", function() kitty.size() end, desc = "kitty Size Picker" })
			table.insert(mappings, { "<leader>kr", function() kitty.reload() end, desc = "kitty Reload Config" })
			table.insert(mappings, { "<leader>ki", function() kitty.status() end, desc = "kitty Status" })
		end

		wk.add(mappings)
	end,
}
