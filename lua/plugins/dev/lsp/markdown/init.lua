require("plugins.dev.lsp.markdown.marksman")
local which = require("utils.which")
local lint = "lint"

if which:is_module_exists(lint) then
	require(lint).linters_by_ft = {
		markdown = {},
	}
end
