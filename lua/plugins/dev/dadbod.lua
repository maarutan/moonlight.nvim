return {
	{
		"kristijanhusak/vim-dadbod-ui",
		init = function()
			vim.g.db_ui_use_nerd_fonts = 1
			vim.g.db_ui_disable_info_notifications = 1

			local api = vim.api

			local DBUI_FTS = {
				dbui = true,
				dbui_table = true,
				dbui_connection = true,
				dbui_result = true,
			}

			local function setup_dbui_keymap()
				local bufnr = api.nvim_get_current_buf()
				local ft = vim.bo[bufnr].filetype

				if not DBUI_FTS[ft] then return end

				local counter = 0
				local function handle_keypress()
					counter = counter + 1
					if counter == 5 then
						counter = 0
						api.nvim_feedkeys(api.nvim_replace_termcodes("<Left>", true, false, true), "n", false)
					else
						api.nvim_feedkeys(api.nvim_replace_termcodes("<Plug>(DBUI_SelectLine)", true, false, true), "n", false)
					end
				end

				local map = vim.keymap.set
				map("n", "l", handle_keypress, { silent = true, buffer = bufnr })
				map("n", "h", handle_keypress, { silent = true, buffer = bufnr })
			end

			api.nvim_create_autocmd("FileType", {
				pattern = { "dbui", "dbui_table", "dbui_connection", "dbui_result" },
				callback = setup_dbui_keymap,
			})
		end,
	},

	{ "tpope/vim-dadbod" },
	{ "kristijanhusak/vim-dadbod-completion" },
}
