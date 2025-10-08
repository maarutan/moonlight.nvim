return function()
    local r = require
    local icons = r("utils.icons")

    local github  = icons.clouds.github  .. "   https://github.com/maarutan/moonlight"
    local author  = icons.copyright      .. "   maarutan"

    return {
        text = "\n"
            .. "\n" .. author
            .. "\n" .. github,

        align = "end",
        padding = 1,
        pane = 2,
    }
end
