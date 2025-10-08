local r = require
local icons = r("utils.icons")

return {
    added = icons.git.added,
    modified = icons.git.modified,
    deleted = icons.git.deleted,
    renamed = icons.git.renamed,

    -- Status type
    untracked = icons.git.untracked,
    ignored = icons.git.ignored,
    unstaged = icons.git.unstaged,
    staged = icons.git.staged,
    conflict = icons.git.conflict,
}
