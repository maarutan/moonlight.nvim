local r = require
local ui = r("utils.ui")
local icons = r("utils.icons")
local which = r("utils.which")
local os = r("utils.os")

return {
	{
		"mason-org/mason.nvim",
		event = "VeryLazy",
		version = "*",
		opts = {
			ui = {
				width = 120,
				height = 28,
				border = ui.border,
				icons = {
					package_installed = icons.complete.installed .. " ",
					package_pending = icons.complete.pending .. " ",
					package_uninstalled = icons.complete.uninstalled .. " ",
				},
			},
			registries = {
				"github:mason-org/mason-registry",
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		event = "VeryLazy",
		version = "*",
		opts = function()
			local tools = {
				"bash-language-server",
				"django-template-lsp",
				"html-lsp",
				"emmet-ls",
				"css-lsp",
				"some-sass-language-server",
				"clangd",
				"lua-language-server",
				"marksman",
				"yaml-language-server",
				"json-lsp",
				"typescript-language-server",
				"sqlls",
				"taplo",
				"rust-analyzer",
				"beautysh",
				"cpplint",
				"eslint_d",
				"htmlhint",
				"markdownlint",
				"pyright",
				"ruff",
				"selene",
				"shellcheck",
				"stylelint",
				"yamllint",
				"black",
				"clang-format",
				"prettier",
				"prettierd",
				"stylua",
			}

			if which:is_exists("hyprctl") then
				table.insert(tools, "hyprls")
			else
				print(icons.emoji.error .. " hyprctl not found (Hyprland is not installed)")
			end

			if os.get_os_id() == "nix" then
				table.insert(tools, "nil")
				table.insert(tools, "alejandra")
			end

			local dependencies = {
				"git",
				"curl",
				"wget",
				"unzip",
				"tar",
				"gzip",
				"npm",
				"cargo",
				"go",
			}

			for _, d in ipairs(dependencies) do
				if not which:is_exists(d) then print(icons.emoji.error .. " " .. d .. " not found") end
			end

			return {
				ensure_installed = tools,
				auto_update = true,
				run_on_start = true,
			}
		end,
	},
}
