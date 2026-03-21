return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		ensure_installed = {
			"c",
			"cpp",
			"regex",
			"lua",
			"vim",
			"vimdoc",
			"query",
			"markdown",
			"markdown_inline",
			"python",
			"javascript",
			"typescript",
			"html",
			"htmldjango",
			"css",
			"bash",
			"json",
			"sql",
			"dockerfile",
			"yaml",
			"toml",
			"rust",
			"go",
			"todotxt",
			"hyprlang",
			"vue",
			"tsx",
			"svelte",
			"astro",
		},

		sync_install = false,
		auto_install = true,

		highlight = {
			enable = true,
			disable = function(_, buf)
				local max_filesize = 100 * 1024
				local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
				return ok and stats and stats.size > max_filesize
			end,
			additional_vim_regex_highlighting = false,
		},

		indent = {
			enable = true,
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)

		vim.filetype.add({
			pattern = {
				[".*/hypr/.*%.conf"] = "hyprlang",
			},
		})
	end,
}
