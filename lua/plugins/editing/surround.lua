return {
	"kylechui/nvim-surround",
	version = "^4.0.0",

	event = "VeryLazy",
	opts = {
		akiases = {
			["a"] = ">",
			["b"] = ")",
			["B"] = "}",
			["r"] = "]",
			["q"] = { '"', "'", "`" },
			["s"] = { "}", "]", ")", ">", '"', "'", "`" },
		},
	},
	keys = {
		{ "ys", mode = "n" },
		{ "yss", mode = "n" },
		{ "yS", mode = "n" },
		{ "ySS", mode = "n" },
		{ "ds", mode = "n" },
		{ "cs", mode = "n" },
		{ "cS", mode = "n" },
		{ "S", mode = "x" },
		{ "gS", mode = "x" },
		{ "<C-g>s", mode = "i" },
		{ "<C-g>S", mode = "i" },
	},
}
