local icons = require("utils.constants.icons")
local which = require("utils.which")

local M = {}

---@class LspServer
---@field name string
---@field executable? string
---@field cmd? string
---@field config? vim.lsp.Config

---@return lsp.ClientCapabilities
function M.capabilities()
	---@type lsp.ClientCapabilities
	local capabilities = vim.lsp.protocol.make_client_capabilities()

	if which:is_module_exists("cmp_nvim_lsp") then
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
	end

	local completion_item = capabilities.textDocument.completion.completionItem
	if completion_item then
		completion_item.snippetSupport = true
	end

	return capabilities
end

---@param executable string
---@return boolean
function M.is_executable(executable)
	return which:is_exists(executable)
end

---@param opts LspServer
---@return boolean
function M.setup_server(opts)
	local name = opts.name
	local config = opts.config or {}
	local default_config = vim.lsp.config[name] or {}
	local default_capabilities = default_config.capabilities or {}

	config.capabilities =
		vim.tbl_deep_extend("force", default_capabilities, M.capabilities(), config.capabilities or {})

	vim.lsp.config(name, config)
	vim.lsp.enable(name)

	return true
end

---@param opts LspServer
---@return boolean
function M.setup_if_executable(opts)
	if opts.executable and not M.is_executable(opts.executable) then
		return false
	end

	return M.setup_server(opts)
end

function M.is_lsp_active(bufnr)
	bufnr = bufnr or 0

	return next(vim.lsp.get_clients({
		bufnr = bufnr,
	})) ~= nil
end

function M.get_icon(bufnr)
	bufnr = bufnr or 0

	if not which:is_module_exists("nvim-web-devicons") then
		return icons.diagnostic.unknown
	end

	local devicons = require("nvim-web-devicons")
	local ft = vim.bo[bufnr].filetype

	return devicons.get_icon_by_filetype(ft, { default = true }) or icons.diagnostic.unknown
end

return M
