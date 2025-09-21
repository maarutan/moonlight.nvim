local capabilities = require("cmp_nvim_lsp").default_capabilities()

local function get_python_path()
	local venv = os.getenv("VIRTUAL_ENV")
	if venv then
		return venv .. "/bin/python" -- Linux/MacOS
	else
		return "/usr/bin/python"
	end
end

vim.lsp.config("pyright", {
	capabilities = capabilities,
	settings = {
		python = {
			pythonPath = get_python_path(),
		},
	},
	filetypes = { "python" },
	root_dir = vim.fs.root(0, {
		"pyrightconfig.json",
		".pyrightconfig.json",
		".git",
		"requirements.txt",
		"setup.py",
		"main.py",
		"manage.py",
	}),
})

vim.lsp.enable("pyright")
