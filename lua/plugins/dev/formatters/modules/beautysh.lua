local r = require
local U = r("plugins.dev.formatters.helper")

return {
    format = function()
        return U.make(
            "beautysh",
            { "--indent-size", "4" },
            true,                   
            false,                 
            function()            
                vim.cmd("edit!")
                vim.cmd("normal! zz")
            end
        )
    end,
}
