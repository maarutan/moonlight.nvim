return{
    -- navigation
    ["L"] = "set_root",
    ["H"] = "navigate_up",

    ["r"] = "rename",
    ["<C-h>"] = "toggle_hidden",

    ["l"] = "smart_enter",
    ["n"] = "toggle_hide_root_node", 

    -- copy
    ["yf"] = "copy_file_name",
    ["yp"] = "copy_file_path",
    ["yd"] = "copy_dir_path",
    ["yw"] = "copy_filename_without_ext",

    -- select
    ["v"] = "visual_line",
    ["<C-v>"] = "visual_line",
    ["V"] = "visual_line",

    -- trash
    ["d"] = "put_trash",
    ["u"] = "restore_from_trash",

    -- none
    ["y"] = "none",
    ["t"] = "none",
}

