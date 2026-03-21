local which = require("utils.which")
local const = require("utils.constants")

return {
	color = { gui = "bold" },
	function()
		local ok, vt = which:is_module_exists("codeium.virtual_text")
		if not ok then
			vt = {
				status = function()
					return { state = "not_found" }
				end,
			}
		end

		color = function()
			local function hex(num)
				return num and string.format("#%06x", num) or nil
			end

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
			const.icons.uiicons.spinner.f1,
			const.icons.uiicons.spinner.f2,
			const.icons.uiicons.spinner.f3,
			const.icons.uiicons.spinner.f4,
			const.icons.uiicons.spinner.f5,
			const.icons.uiicons.spinner.f6,
			const.icons.uiicons.spinner.f7,
			const.icons.uiicons.spinner.f8,
			const.icons.uiicons.spinner.f9,
			const.icons.ui.spinner.f10,
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
			return "%#WindsurfThink#" .. spinner_symbol .. " " .. const.icons.ui.brain
		elseif status.state == "completions" and (status.total or 0) > 0 then
			return "%#WindsurfComplete#"
				.. string.format("%s %d/%d", const.icons.ui.ai.finded, status.current or 0, status.total)
		elseif status.state == "idle" then
			return "%#WindsurfIdle#" .. const.icons.ui.ai.idle
		elseif status.state == "not_found" then
			return "%#WindsurfNotFound#" .. ("[ " .. const.icons.ui.ai.not_found .. " ? `Windsurf` ]")
		else
			return "%#WindsurfNotFound#" .. "[ ? `Windsurf` ]"
		end
	end,
}
