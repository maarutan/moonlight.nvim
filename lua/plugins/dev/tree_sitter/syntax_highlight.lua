return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",

		config = function()
			local ts = require("nvim-treesitter")

			ts.setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})

			vim.filetype.add({
				pattern = {
					[".*/hypr/.*%.conf"] = "hyprlang",
				},
			})

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

			local installed = require("nvim-treesitter.config").get_installed()

			local missing = vim.iter(parsers)
				:filter(function(lang)
					return not vim.tbl_contains(installed, lang)
				end)
				:totable()

			if #missing > 0 then
				ts.install(missing)
			end

			local aug = vim.api.nvim_create_augroup("MyTreeSitter", { clear = true })

			vim.api.nvim_create_autocmd("FileType", {
				group = aug,
				callback = function(args)
					local buf = args.buf

					pcall(vim.treesitter.start, buf)

					if vim.bo[buf].buftype == "" then
						vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},
}
