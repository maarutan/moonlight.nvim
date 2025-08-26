local import_modules = {
	"vim_visual_multi",
	"mode_preview",
	"repo_preview",
	"git_branch",
	"git_diff",
	"noice_endered_command",
	"dodbod_preview",
	"lsp_diagnostics",
	"lsp_status",
	"codeium",
	"copilot",
	"visual_mode_progress",
	"last_color",
}
local import_core = {
	"options",
}
local function lualine(m)
	require("lualine").setup({
		options = m.options,
		sections = {
			lualine_a = { m.mode_preview },
			lualine_b = {
				m.git_branch,
				m.git_diff,
				m.lsp_diagnostics,
				m.lsp_status,

				{
					"lsp_status",
					icon = "  LSP:",
					color = { fg = "#ffffff", gui = "bold" },
					symbols = {
						spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
						done = "",
					},
				},
			},
			lualine_c = { "filename", m.repo_preview, m.dadbod_preview },
			lualine_x = { m.last_color, "encoding", "fileformat", "filetype", m.codeium },
			lualine_y = { m.noice_endered_command, "progress" },
			lualine_z = {
				"location",
			},
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = {},
	})
end

local modules = {}
for _, mod_name in ipairs(import_modules) do
	local ok, mod = pcall(require, "plugins.ui.lualine.modules." .. mod_name)
	if ok then
		modules[mod_name] = mod
	else
		vim.notify("Failed to load module " .. mod_name, vim.log.levels.WARN)
	end
end

for _, mod_name in ipairs(import_core) do
	local ok, mod = pcall(require, "plugins.ui.lualine.core." .. mod_name)
	if ok then
		modules[mod_name] = mod
	else
		vim.notify("Failed to load module " .. mod_name, vim.log.levels.WARN)
	end
end

lualine(modules)
