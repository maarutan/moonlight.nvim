return {
	function()
		-- local not_repo = "[  not in repo ]"
		local not_repo = ""

		local git_dir = vim.fn.finddir(".git", vim.fn.expand("%:p:h") .. ";")
		if git_dir == "" then
			return not_repo
		end

		local handle = io.popen("git config --get remote.origin.url 2>/dev/null")
		if not handle then
			return not_repo
		end

		local url = handle:read("*a") or ""
		handle:close()
		url = vim.trim(url)
		if url == "" then
			return not_repo
		end

		local name = url:match("([^/]+)%.git$") or url:match("([^/]+)$")
		if not name then
			return not_repo
		end
		name = vim.trim(name)

		local hosts_patterns = {
			["github"] = "github%.com",
			["gitlab"] = "gitlab%.com",
			["aur"] = "aur%.archlinux%.org",
			["bitbucket"] = "bitbucket%.org",
			["sourceforge"] = "sourceforge%.net",
			["azure"] = "azure%.com",
			["gitkraken"] = "gitkraken%.com",
			["aws"] = "aws%.amazon%.com",
		}

		local host = "git"
		for h, pattern in pairs(hosts_patterns) do
			if url:match(pattern) then
				host = h
				break
			end
		end

		local clouds = {
			aur = "󰣇",
			github = "",
			gitlab = "",
			bitbucket = "",
			sourceforge = "󱠇",
			azure = "",
			gitkraken = "",
			aws = "",
			git = "󰊢",
		}

		local icon = clouds[host] or clouds.git

		return string.format("%s %s", icon, name)
	end,
}
