return {
	-- 🌳 Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
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
				custom_captures = {
					["keyword"] = "italic",
					["comment"] = "italic",
				},
				disable = function(lang, buf)
					local max_filesize = 100 * 1024
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then return true end
				end,
				additional_vim_regex_highlighting = false,
			},

			indent = { enable = true },

			matchup = {
				enable = true, -- mandatory, false will disable the whole extension
				disable = { "" }, -- optional, list of languages to be disabled
			},

			rainbow = {
				enable = true,
				extended_mode = true,
				max_file_lines = 1000,
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)

			vim.filetype.add({
				pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
			})

			vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
				pattern = "*.conf",
				command = "set filetype=dosini",
			})
		end,
	},
}
