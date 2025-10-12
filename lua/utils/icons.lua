local M = {}

M.header = [[                                                     





┌┬┐┌─┐┌─┐┌┐┌┬  ┬┌─┐┬ ┬┌┬┐             Z
││││ ││ │││││  ││ ┬├─┤ │           z
┴ ┴└─┘└─┘┘└┘┴─┘┴└─┘┴ ┴ ┴ .nvim  z
]]

M.lazy = "󰒲"
M.nvim = ""
M.version = M.nvim

M.languages = {
	lua = "",
}

M.complete = {
	installed = "󰄲",
	pending = "",
	uninstalled = "",
}

M.lsp = ""

M.git = {
	modified = "",
	added = "",
	untracked = "",
	deleted = "",
	ignored = "",
	updated = " ",
	unstaged = "",
	renamed = "",
	conflict = "",
	staged = "",
}

M.kitty = {
	title = "",
	group = "󰄛",
}

M.find = ""
M.neotree = "󰙅"
M.notification = ""
M.lightning = "󱐋"

M.new_file = ""
M.recent_file = "󱋡"
M.config = ""
M.word = ""

M.emoji = {
	dir = "📁",
	file = "📄",
	unknown = "❓",
	error = "❌",
	pin = "📌",
	resize = "♻️",
	warn = "⚠️",
	put_trash = "🚮",
	trash = "🗑️",
	restore = "♻️",
	rocket = "🚀",
	lightning = "⚡️",
	dream = "💤",
	success = "✅",
}

M.exit = "󰩈"

M.trash_cli = {
	put_trash = M.emoji.put_trash,
	restore = M.emoji.restore,
}

M.spinner = {
	f1 = "⠋",
	f2 = "⠙",
	f3 = "⠹",
	f4 = "⠸",
	f5 = "⠼",
	f6 = "⠴",
	f7 = "⠦",
	f8 = "⠧",
	f9 = "⠇",
	f10 = "⠏",
}

M.windsurf = {
	idle = "󰚩",
	think = "󱚣",
	finded = "󱚥",
	not_found = "󱚟",
	off = "󱚧",
}

M.brain = "󰧑"

M.clouds = {
	aur = "󰣇", -- Arch AUR
	github = "", -- GitHub Octocat
	gitlab = "", -- GitLab
	bitbucket = "", -- Bitbucket
	sourceforge = "󱠇",
	azure = "", -- Azure DevOps
	aws = "", -- AWS CodeCommit
	gitkraken = "",
	codeberg = "",
	srht = "󰛡", -- SourceHut
	gitea = "󰊢",
	forgejo = "󰊢",
	heptapod = "󰓩",
	pagure = "󰚝",
	opendev = "",
	cgit = "󰊢",
	savannah = "",
	notabug = "󰚌",
	sourcehut = "󰛡",
	launchpad = "",
	assembla = "󰕣",
	phabricator = "󰡖",
	beanstalk = "󰏗",
	teamforge = "󰙴",
	google = "󰊭",
	git = "󰊢",
}

M.diagnostic = {
	error = "",
	warn = "",
	hint = "",
	info = "",
}

M.noice = {
	command = "󰘳",
	not_found = M.diagnostic.warn,
}

M.directory = {
	open = "",
	close = "",
}
M.calendar = "󰱆"

M.comments = {
	group = "",
	block = "󰍵",
	line = "󰈚",
}

M.mode = {
	normal = "",
	insert = "",
	terminal = "",
	visual = "󰈈",
	cmdline = "",
	replace = "󰑕",
}

M.unknown = ""
M.color = ""
M.terminal = ""

M.left_trunc_marker = ""
M.right_trunc_marker = ""
M.pin = M.emoji.pin

M.radio_on = " "
M.radio_off = " "

M.day = "󰖨"
M.night = ""

M.vertical_space_bar = "▎"
M.indent_line = "│"
M.last_indent_marker = "└"
M.horizontal_bar = "─"
M.tabs = ""
M.extends = "󰜵"
M.precedes = "󰜲"
M.expander_collapsed = ""
M.expander_expanded = ""

M.fold = {
	open = "",
	close = "",
}

M.copyright = ""

-- state
M.not_save = "[+]"
M.close = ""

M.buffer = "󰓩"

M.cmp_icons = {
	codeium = M.windsurf.idle,
	copilot = "",
	calc = "󰃬",
}

M.hop = ""
M.menu = "󱡠"

M.folders = {
	close = "",
	open = "",
	empty = "󰉖",
	empty_open = "󰷏",
}

M.web_icons = {
	files = {
		{ "lua", "" },
	},
	directories = {
		{ ".config", "" },
		{ ".exercism", "" },
		{ ".git", "" },
		{ ".github", "" },
		{ ".npm", "" },
		{ ".opam", "" },
		{ ".ssh", "󰢬" },
		{ ".Trash", "" },
		{ "build", "󱧼" },
		{ "config", "" },
		{ "Contacts", "󰉌" },
		{ "cron.d", "" },
		{ "cron.daily", "" },
		{ "cron.hourly", "" },
		{ "cron.minutely", "" },
		{ "cron.monthly", "" },
		{ "cron.weekly", "" },
		{ "Desktop", "" },
		{ "Documents", "󰲂" },
		{ "Downloads", "󰉍" },
		{ "etc", "" },
		{ "Favorites", "󰚝" },
		{ "hidden", "󱞞" },
		{ "home", "󱂵" },
		{ "include", "" },
		{ "Mail", "󰇰" },
		{ "Movies", "󰿎" },
		{ "Music", "󱍙" },
		{ "node_modules", "" },
		{ "npm_cache", "" },
		{ "pacman.d", "" },
		{ "pam.d", "󰢬" },
		{ "Pictures", "󰉏" },
		{ "src", "󰣞" },
		{ "ssh", "󰢬" },
		{ "sudoers.d", "󰢬" },
		{ "Videos", "" },
		{ "xbps.d", "" },
		{ "xorg.conf.d", "" },
		{ "cabal", "" },
		{ "components", "󱧼" },
		{ "templates", "󱧼" },
		{ "tmp", "" },
	},
}

return M
