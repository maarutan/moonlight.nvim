return {
	"isakbm/gitgraph.nvim",
	event = "VeryLazy",
	opts = {
		git_cmd = "git",

		window = {
			layout = "float", -- float || split || vsplit || full
			-- if layout is float
			width = 0.8, -- screen share or number of columns
			height = 0.8, -- screen share or number of lines

			close = "q", -- if current buffer is gitgraph, close it
			border = "rounded", -- single || double || rounded || none
		},

		symbols = {
			merge_commit = "M",
			commit = "*",
		},
		format = {
			timestamp = "%H:%M:%S %d-%m-%Y",
			fields = { "hash", "timestamp", "author", "branch_name", "tag" },
		},
		hooks = {
			on_select_commit = function(commit) print("selected commit:", commit.hash) end,
			on_select_range_commit = function(from, to) print("selected range:", from.hash, to.hash) end,
		},
	},
}
