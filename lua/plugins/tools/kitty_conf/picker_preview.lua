local kitty_api = require("plugins.tools.kitty_conf.kitty_api")

local function font_preview(ctx, state)
	state = state or {}

	local name = ctx.item and ctx.item.text or "?"

	if ctx.preview then
		ctx.preview:reset()
		ctx.preview:set_title("Font: " .. name)
		ctx.preview:set_lines({
			[[    ┬┌─┬┌┬┐┌┬┐┬ ┬  ┌─┐┌─┐┌┐┌┌┬┐┌─┐
    ├┴┐│ │  │ └┬┘  ├┤ │ ││││ │ └─┐
    ┴ ┴┴ ┴  ┴  ┴   └  └─┘┘└┘ ┴ └─┘    ]],
			"",
			"--------------------------------------------------------",
			"Selected:  [ " .. name .. " ]",
			"{",
			"   Current:   " .. (state.current_font or state.font or "---"),
			"   Size:      " .. tostring(state.size or "---"),
			"}",
			"--------------------------------------------------------",
			"-> PI            :  3.14159265359",
			"-> Lorem ipsum   :  consectetur adipiscing elit.",
			"-> Special chars :  !@#$%^&*()_+=-{}|~`?<>:;\\/.,",
			"-> Legatures     : === !== != >= => <- www ***",
			"-> Nerd Font     :   󰌠           󰮯  ",
			"",
		})
	end

	kitty_api.preview_font(name)
end

return font_preview
