return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",

		config = function()
			require("nvim-treesitter").setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})

			vim.filetype.add({
				pattern = {
					[".*/hypr/.*%.conf"] = "hyprlang",
				},
			})

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
