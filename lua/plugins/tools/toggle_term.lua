return {
	-- 🔥 toggleterm
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			local r = require
			local ui = r("utils.ui")
			local size = 20

			if ui.termianl_direction == "vertical" then
				size = 50
			end

			require("toggleterm").setup({
				direction = "horizontal",
				start_in_insert = true,
				persist_mode = false,
				size = size,
				float_opts = {
					border = ui.border,
					width = 130,
					height = 27,
				},
			})

			function _G.set_terminal_keymaps()
				local opts = { buffer = 0, noremap = true, silent = true }
				vim.keymap.set("t", "<C-BS>", [[<C-w>]], opts)
				vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "W^", [[<C-w>]], opts)
			end

			vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
		end,
	},

	-- 🚀 code-runner
	{
		"maarutan/toggleterm-coderunner.nvim",

		dependencies = { "akinsho/toggleterm.nvim" },
		config = function()
			local r = require
			local ui = r("utils.ui")

			r("toggleterm-coderunner").setup({
				commands = {
					python = "python3 -u $dir/$fileName",
					lua = "lua $dir/$fileName",
					sh = "sh $dir/$fileName",
					zsh = "zsh $dir/$fileName",
					html = "xdg-open $dir/$fileName",
					c = "gcc $dir/$fileName -o $dir/output && $dir/output && rm $dir/output",
					cpp = "g++ $dir/$fileName -o $dir/output && $dir/output && rm $dir/output",
				},

				extensions = {
					python = { "py" },
					lua = { "lua" },
					sh = { "sh" },
					zsh = { "zsh" },
					html = { "html" },
					c = { "c" },
					cpp = { "cpp", "c++" },
				},
			})
		end,
	},
}
