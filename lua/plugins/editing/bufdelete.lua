return {
	"famiu/bufdelete.nvim",
	version = "*",
	config = function()
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

				if
					not skip
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
