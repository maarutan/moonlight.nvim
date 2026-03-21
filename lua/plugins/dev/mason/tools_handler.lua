local M = {}

local notified = {}

local tools_by_ft = {
	python = { "pyright", "ruff" },
	lua = { "lua-language-server", "stylua" },
	javascript = { "typescript-language-server", "prettier", "emmet-ls" },
	typescript = { "typescript-language-server", "prettier", "emmet-ls" },
	javascriptreact = {
		"typescript-language-server",
		"prettier",
		"emmet-ls",
		"html-lsp",
		"css-lsp",
	},
	typescriptreact = {
		"typescript-language-server",
		"prettier",
		"emmet-ls",
		"html-lsp",
		"css-lsp",
	},
	html = { "html-lsp", "css-lsp", "emmet-ls", "prettier" },
	css = { "css-lsp", "prettier" },
	json = { "json-lsp", "prettier" },
	yaml = { "yaml-language-server" },
	toml = { "taplo" },
	sh = { "bash-language-server" },
	bash = { "bash-language-server" },
	zsh = { "bash-language-server" },
	go = { "gopls" },
	rust = { "rust-analyzer", "rustfmt" },
	c = { "clangd", "clang-format" },
	cpp = { "clangd", "clang-format" },
	md = { "marksman" },
	markdown = { "marksman" },
}

local function is_installed(pkg)
	local ok, registry = pcall(require, "mason-registry")
	if not ok then return false end

	if not registry.has_package(pkg) then return false end

	local package = registry.get_package(pkg)
	return package:is_installed()
end

function M.check()
	local ft = vim.bo.filetype
	if ft == "" or notified[ft] then return end

	local tools = tools_by_ft[ft]
	if not tools or vim.tbl_isempty(tools) then return end

	local missing = {}

	for _, tool in ipairs(tools) do
		if not is_installed(tool) then table.insert(missing, tool) end
	end

	if #missing == 0 then return end

	notified[ft] = true

	vim.notify(
		string.format(
			"Missing tools for %s: %s\nRun :MasonInstall %s",
			ft,
			table.concat(missing, ", "),
			table.concat(missing, " ")
		),
		vim.log.levels.WARN,
		{ title = "Mason" }
	)
end

function M.setup()
	vim.api.nvim_create_autocmd("FileType", {
		callback = function() M.check() end,
	})
end

return M
