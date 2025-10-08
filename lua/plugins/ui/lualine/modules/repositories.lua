local r = require
local icons = r("utils.icons")
return {
	function()
		local not_repo = "[  not in repo ]"
		-- local not_repo = ""

		local git_dir = vim.fn.finddir(".git", vim.fn.expand("%:p:h") .. ";")
		if git_dir == "" then return not_repo end

		local handle = io.popen("git config --get remote.origin.url 2>/dev/null")
		if not handle then return not_repo end

		local url = handle:read("*a") or ""
		handle:close()
		url = vim.trim(url)
		if url == "" then return not_repo end

		local name = url:match("([^/]+)%.git$") or url:match("([^/]+)$")
		if not name then return not_repo end
		name = vim.trim(name)

		local hosts_patterns = {
			["github"] = "github%.com",
			["gitlab"] = "gitlab%.com",
			["aur"] = "aur%.archlinux%.org",
			["bitbucket"] = "bitbucket%.org",
			["sourceforge"] = "sourceforge%.net",
			["azure"] = "dev%.azure%.com",
			["aws"] = "git-codecommit%.",
			["gitkraken"] = "gitkraken%.com",
			["codeberg"] = "codeberg%.org",
			["srht"] = "git%.sr%.ht",
			["gitea"] = "gitea%.io",
			["forgejo"] = "forgejo%.org",
			["heptapod"] = "heptapod%.net",
			["pagure"] = "pagure%.io",
			["opendev"] = "opendev%.org",
			["cgit"] = "cgit%.",
			["savannah"] = "savannah%.gnu%.org",
			["notabug"] = "notabug%.org",
			["sourcehut"] = "sourcehut%.org",
			["launchpad"] = "launchpad%.net",
			["assembla"] = "assembla%.com",
			["phabricator"] = "phabricator%.",
			["beanstalk"] = "beanstalkapp%.com",
			["teamforge"] = "teamforge%.com",
			["google"] = "chromium%.googlesource%.com",
		}

		local host = "git"
		for h, pattern in pairs(hosts_patterns) do
			if url:match(pattern) then
				host = h
				break
			end
		end

		local icon = icons.clouds[host] or icons.clouds.git

		return string.format("%s %s", icon, name)
	end,
}
