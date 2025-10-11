return {
	color = { gui = "bold" },
	function()
		local r = require
		local which = r("utils.which")
		local icons = r("utils.icons")

		local ok, vt = which:is_module_exists("codeium.virtual_text")
		if not ok then vt = { status = function() return { state = "not_found" } end } end

		color = function()
			local function hex(num) return num and string.format("#%06x", num) or nil end

			local hl = vim.api.nvim_get_hl(0, { name = "lualine_a_normal" })

			return hex(hl.bg)
		end

		local dayColors = {
			idle = color(),
			think = "#FF8C00",
			complete = "#228B22",
			not_found = "#CC0000",
		}

		local nightColors = {
			idle = color(),
			think = "#D48A00",
			complete = "#259A55",
			not_found = "#C0392B",
		}

		local spinner = {
			icons.spinner.f1,
			icons.spinner.f2,
			icons.spinner.f3,
			icons.spinner.f4,
			icons.spinner.f5,
			icons.spinner.f6,
			icons.spinner.f7,
			icons.spinner.f8,
			icons.spinner.f9,
			icons.spinner.f10,
		}
		local colors = (vim.o.background == "light") and dayColors or nightColors

		vim.api.nvim_set_hl(0, "WindsurfIdle", { fg = colors.idle, bold = true })
		vim.api.nvim_set_hl(0, "WindsurfThink", { fg = colors.think, bold = true })
		vim.api.nvim_set_hl(0, "WindsurfComplete", { fg = colors.complete, bold = true })
		vim.api.nvim_set_hl(0, "WindsurfNotFound", { fg = colors.not_found, bold = true })

		local hrtime = (vim.uv or vim.loop).hrtime
		local spinner_symbol = spinner[math.floor(hrtime() / (1e6 * 80)) % #spinner + 1]

		local status = vt.status()

		if status.state == "waiting" then
			return "%#WindsurfThink#" .. spinner_symbol .. " " .. icons.brain
		elseif status.state == "completions" and (status.total or 0) > 0 then
			return "%#WindsurfComplete#" .. string.format("%s %d/%d", icons.windsurf.finded, status.current or 0, status.total)
		elseif status.state == "idle" then
			return "%#WindsurfIdle#" .. icons.windsurf.idle
		elseif status.state == "not_found" then
			return "%#WindsurfNotFound#" .. ("[ " .. icons.windsurf.not_found .. " ? `Windsurf` ]")
		else
			return "%#WindsurfNotFound#" .. "[ ? `Windsurf` ]"
		end
	end,
}
