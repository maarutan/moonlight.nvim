require("plugins.dev.lsp.markdown.marksman")
local which = require("utils.which")
local lint = "lint"

if which:is_module_exists(lint) then
	local lint_config = require(lint)
	lint_config.linters_by_ft = lint_config.linters_by_ft or {}
	lint_config.linters_by_ft.markdown = {}
end
