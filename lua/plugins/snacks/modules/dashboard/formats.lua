return {
    icon = function(item)
        if item.file and (item.icon == "file" or item.icon == "directory") then
            return { icons.get(item.file), width = 2, hl = "icon" }
        end
        return { item.icon, width = 2, hl = "icon" }
    end,
    footer = { "%s", align = "center" },
    header = { "%s", align = "center" },
    file = function(item, ctx)
        local fname = vim.fn.fnamemodify(item.file, ":~")
        fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
        if #fname > ctx.width then
            local dir = vim.fn.fnamemodify(fname, ":h")
            local file = vim.fn.fnamemodify(fname, ":t")
            if dir and file then
                file = file:sub(-(ctx.width - #dir - 2))
                fname = dir .. "/…" .. file
            end
        end
        local dir, file = fname:match("^(.*)/(.+)$")
        return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } }
               or { { fname, hl = "file" } }
    end,
}
