local M = {}

local r = require
local d = "plugins.tools.kitty_term."
function M.font_preview(ctx, last_ctx)
	ctx.preview:reset()
	local name = ctx.item and ctx.item.text or "?"
	ctx.preview:set_title("Font: " .. name)
	ctx.preview:set_lines({
		[[    ┬┌─┬┌┬┐┌┬┐┬ ┬  ┌─┐┌─┐┌┐┌┌┬┐┌─┐
    ├┴┐│ │  │ └┬┘  ├┤ │ ││││ │ └─┐
    ┴ ┴┴ ┴  ┴  ┴   └  └─┘┘└┘ ┴ └─┘    ]],
		"",
		"--------------------------------------------------------",
		"Selected:  [ " .. name .. " ]",
		"{",
		"   Current:   " .. (last_ctx.font or "---"),
		"   Size:      " .. (last_ctx.size or "---"),
		"   Default:   " .. (last_ctx.default_font or "---"),
		"}",
		"--------------------------------------------------------",
		"-> PI            :  3.14159265359",
		"-> Lorem ipsum   :  consectetur adipiscing elit.",
		"-> Special chars :  !@#$%^&*()_+=-{}|~`?<>:;\\/.,",
		"-> Legatures     : === !== != >= => <- www ***",
		"-> Nerd Font     :   󰌠           󰮯  ",
		"",
	})
	r(d .. "core").set_font(name)
end

return M
