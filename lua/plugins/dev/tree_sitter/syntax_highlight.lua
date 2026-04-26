local parsers = {
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
}

return {
	"nvim-treesitter/nvim-treesitter",

	branch = "main",
	version = false,
	lazy = false,

	build = ":TSUpdate",

	config = function()
		vim.filetype.add({
			pattern = {
				[".*/hypr/.*%.conf"] = "hyprlang",
			},
		})

		local ts = require("nvim-treesitter")

		ts.setup({
			install_dir = vim.fn.stdpath("data") .. "/site",
		})

		ts.install(parsers)

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("MoonlightTreesitter", { clear = true }),
			callback = function(args)
				local max_filesize = 100 * 1024
				local filename = vim.api.nvim_buf_get_name(args.buf)

				if filename ~= "" then
					local ok, stats = pcall(vim.uv.fs_stat, filename)

					if ok and stats and stats.size > max_filesize then
						return
					end
				end

				pcall(vim.treesitter.start, args.buf)

				pcall(function()
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end)
			end,
		})
	end,
}
