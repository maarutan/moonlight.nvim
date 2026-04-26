local icons = require("utils.constants.icons.ui")

return {
	{ "<A-h>", "V<Plug>GoVSMLeft<Esc>", desc = "Move line " .. icons.arrows.left, mode = "n" },
	{ "<A-j>", "V<Plug>GoVSMDown<Esc>", desc = "Move line " .. icons.arrows.down, mode = "n" },
	{ "<A-k>", "V<Plug>GoVSMUp<Esc>", desc = "Move line " .. icons.arrows.up, mode = "n" },
	{ "<A-l>", "V<Plug>GoVSMRight<Esc>", desc = "Move line " .. icons.arrows.right, mode = "n" },

	{ "<A-h>", "<Plug>GoVSMLeft", desc = "Move selection " .. icons.arrows.left, mode = "v" },
	{ "<A-j>", "<Plug>GoVSMDown", desc = "Move selection " .. icons.arrows.down, mode = "v" },
	{ "<A-k>", "<Plug>GoVSMUp", desc = "Move selection " .. icons.arrows.up, mode = "v" },
	{ "<A-l>", "<Plug>GoVSMRight", desc = "Move selection " .. icons.arrows.right, mode = "v" },

	{ "<A-S-C-h>", "<Plug>GoNSDLeft", desc = "Duplicate " .. icons.arrows.left, mode = "n" },
	{ "<A-S-C-j>", "<Plug>GoNSDDown", desc = "Duplicate " .. icons.arrows.down, mode = "n" },
	{ "<A-S-C-k>", "<Plug>GoNSDUp", desc = "Duplicate " .. icons.arrows.up, mode = "n" },
	{ "<A-S-C-l>", "<Plug>GoNSDRight", desc = "Duplicate " .. icons.arrows.right, mode = "n" },

	{
		"<A-S-C-h>",
		"<Plug>GoVSDLeft",
		desc = "Duplicate selection " .. icons.arrows.left,
		mode = "x",
	},
	{
		"<A-S-C-j>",
		"<Plug>GoVSDDown",
		desc = "Duplicate selection " .. icons.arrows.down,
		mode = "x",
	},
	{ "<A-S-C-k>", "<Plug>GoVSDUp", desc = "Duplicate selection " .. icons.arrows.up, mode = "x" },
	{
		"<A-S-C-l>",
		"<Plug>GoVSDRight",
		desc = "Duplicate selection " .. icons.arrows.right,
		mode = "x",
	},
}
