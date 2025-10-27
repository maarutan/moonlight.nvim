return {
	"famiu/bufdelete.nvim",
	version = "*",
	config = function()
		vim.api.nvim_create_user_command("Bdelete", function(opts)
			local bufnr = tonumber(opts.args)
			if not bufnr then bufnr = vim.api.nvim_get_current_buf() end

			vim.api.nvim_exec_autocmds("BufDelete", { buffer = bufnr })

			require("bufdelete").bufdelete(bufnr, opts.bang)
		end, {
			bang = true,
			nargs = "?",
			complete = "buffer",
			desc = "Close buffer and fire BufDelete autocmd first",
		})

		local exclude = {
			"neo-tree",
			"NvimTree",
		}

		vim.g.bufdelete_buf_filter = function()
			local allowed = {}

			for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
				local ft = vim.bo[bufnr].filetype
				local skip = false

				for _, v in ipairs(exclude) do
					if ft == v then
						skip = true
						break
					end
				end

				if not skip and vim.api.nvim_buf_is_loaded(bufnr) and vim.bo[bufnr].buftype == "" and vim.bo[bufnr].buflisted then table.insert(allowed, bufnr) end
			end

			return allowed
		end
	end,
}
