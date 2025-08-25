local wk = require("which-key")
local border = require("core.options").border

wk.setup({
	preset = "modern", --  "classic" | "modern" | "helix"
	win = {
		border = border,
	},
})

wk.add({
	{ "<leader>f", group = "Find" },
	{ "<leader>ff", desc = "Find File" },
	{ "<leader>fW", desc = "Find Word Under Cursor" },
	{ "<leader>fu", desc = "Find Undo" },
	{ "<leader>fw", desc = "Find Word " },
	{ "<leader>fb", desc = "Find Buffer" },
	{ "<leader>fh", desc = "Find Help" },
	{ "<leader>fr", desc = "Find Recent" },
	{ "<leader>fR", desc = "Find Recent and change directory" },

	{ "<leader>g", group = "Git" },
	{ "<leader>gb", desc = "Open Branches" },
	{ "<leader>gc", desc = "Open Commits" },
	{ "<leader>gs", desc = "Open Status" },
	{ "<leader>gd", desc = "Open Diff View" },
	{ "<leader>gl", desc = "Open lazy git" },

	{ "<leader>e", desc = "Open Neotree" },
	{ "<leader>u", desc = "Undo" },
	{ "<leader>b", desc = "Buffer" },
	{ "<leader>w", desc = "Windows" },
	{ "<leader>h", desc = "hop" },
	{ "<leader>t", desc = "Terminal" },

	{ "<leader>;", desc = "cmdline History" },
	{ "<leader>:", desc = "cmdline Complete" },

	{ "<leader>n", group = "Notify" },
	{ "<leader>nu", desc = "Clear Notify" },
	{ "<leader>nh", desc = "Notify History" },

	{ "<leader>.", group = "Current `.`" },
	{ "<leader>..", desc = "Current File Path" },
	{ "<leader>.y", desc = "Current File Path Copy" },

	{ "<leader>p", group = "Postion Cursor" },
	{ "<leader>ph", desc = "High" },
	{ "<leader>pm", desc = "Middle" },
	{ "<leader>pl", desc = "Low" },

	{ "<leader>l", group = "LSP" },
	{ "<leader>ld", "<cmd>Lspsaga goto_definition<CR>", desc = "Declaration" },
	{ "<leader>lD", "<cmd>Lspsaga goto_type_definition<CR>", desc = "Type Definition" },
	{ "<leader>lh", "<cmd>Lspsaga hover_doc<CR>", desc = "Hover Doc" },
	{ "<leader>li", "<cmd>Lspsaga show_line_diagnostics<CR>", desc = "Implementation" },
	{ "<leader>lk", "<cmd>Lspsaga hover_doc<CR>", desc = "Hover" },
	{ "<leader>lI", "<cmd>LspInfo<CR>", desc = "Info" },
	{ "<leader>lR", "<cmd>LspRestart<CR>", desc = "Restart" },
	{ "<leader>lr", "<cmd>Lspsaga rename<CR>", desc = "Rename" },
	{ "<leader>la", "<cmd>Lspsaga code_action<CR>", desc = "Code Action" },
	{ "<leader>lo", "<cmd>Lspsaga outline<CR>", desc = "Outline" },
	{ "<leader>lS", "<cmd>LspStop<CR>", desc = "Stop LSP" },
	{ "<leader>ls", "<cmd>LspStart<CR>", desc = "Start LSP" },
	{ "<leader>dw", "<cmd>Lspsaga show_workspace_diagnostics<CR>", desc = "Workspace Diagnostics" },
	{ "<leader>dc", "<cmd>Lspsaga show_line_diagnostics<CR>", desc = "Line Diagnostics" },
	{ "<leader>dl", "<cmd>Lspsaga diagnostic_jump_next<CR>", desc = "Next Diagnostic" },
	{ "<leader>dh", "<cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "Prev Diagnostic" },

	{ "<leader>d", group = "LSP Diagnostics" },
	{ "<leader>dh", desc = "Goto Prev Diagnostics" },
	{ "<leader>dl", desc = "Goto Next Diagnostics" },
	{ "<leader>dw", desc = "Workspace Diagnostics" },
	{ "<leader>dc", desc = "Line Diagnostics" },

	{ "<leader>D", desc = "Dashboard" },

	{ "<leader>c", group = "Comment & Colors" },
	{ "<leader>cl", desc = "Comment line" },
	{ "<leader>cc", desc = "CccConvert line" },
	{ "<leader>cp", desc = "CccPick" },

	{ "<leader>o", group = "Option" },
	{ "<leader>oc", desc = "cd init dir" },
}, { prefix = "<leader>" })
