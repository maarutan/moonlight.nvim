return function()
    local r = require
    local which = r("utils.which")
    local img_path = vim.fn.stdpath("config") .. "/lua/assets/user.jpg"

    local min_w, min_h = 80, 30

    if vim.o.columns < min_w or vim.o.lines < min_h or not which:is_exists("ascii-image-converter") then
        return nil
    end

    local win_w, win_h = vim.o.columns, vim.o.lines
    local img_w = math.floor(win_w * 0.3)
    local img_h = math.floor(win_h * 0.5)

    local cmd = string.format(
        "ascii-image-converter %s -C -c -d %d,%d",
        img_path,
        img_w,
        img_h
    )

    return {
        section = "terminal",
        cmd = cmd,
        pane = 2,
        height = img_h,
    }
end
