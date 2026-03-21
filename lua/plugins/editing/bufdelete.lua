return {
	"famiu/bufdelete.nvim",
	version = "*",

	config = function()
		local bufdelete = require("bufdelete")

		vim.api.nvim_create_user_command("Bdelete", function(opts)
			local bufnr = tonumber(opts.args) or vim.api.nvim_get_current_buf()

			if vim.api.nvim_buf_is_valid(bufnr) then
				vim.api.nvim_exec_autocmds("BufDelete", { buffer = bufnr })
				bufdelete.bufdelete(bufnr, opts.bang)
			end
		end, {
			bang = true,
			nargs = "?",
			complete = "buffer",
			desc = "Close buffer and fire BufDelete autocmd first",
		})

		local exclude = {
			["neo-tree"] = true,
			["NvimTree"] = true,
		}

		vim.g.bufdelete_buf_filter = function()
			local allowed = {}

			for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
				local ft = vim.bo[bufnr].filetype

				if
					not exclude[ft]
					and vim.api.nvim_buf_is_loaded(bufnr)
					and vim.bo[bufnr].buftype == ""
					and vim.bo[bufnr].buflisted
				then
					table.insert(allowed, bufnr)
				end
			end

			return allowed
		end
	end,
}
