local icons = require("utils.constants.icons")
local which = require("utils.which")

local M = {}
function M.capabilities()
	local capabilities = vim.lsp.protocol.make_client_capabilities()

	if which:is_module_exists("cmp_nvim_lsp") then
		local cmp = require("cmp_nvim_lsp")
		capabilities = cmp.default_capabilities(capabilities)
	end

	capabilities.textDocument.completion.completionItem.snippetSupport = false

	return capabilities
end

function M.is_lsp_active(bufnr)
	bufnr = bufnr or 0
	local clients = vim.lsp.get_clients({ bufnr = bufnr })
	return #clients > 0
end

function M.get_icon(bufnr)
	bufnr = bufnr or 0

	if not which:is_module_exists("nvim-web-devicons") then
		return icons.diagnostic.unknown
	end

	if not M.is_lsp_active(bufnr) then
		return icons.diagnostic.unknown
	end

	local devicons = require("nvim-web-devicons")
	local ft = vim.bo[bufnr].filetype
	local icon = devicons.get_icon_by_filetype(ft, { default = true })

	return icon or icons.diagnostic.unknown
end

return M
