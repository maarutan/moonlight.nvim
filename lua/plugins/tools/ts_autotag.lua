return {
	"windwp/nvim-ts-autotag",
	version = "*",
	opts = {
		close = true,
		rename = true,
		close_on_slash = true,

		per_filetype = {
			html = {
				close = true,
			},
		},
	},
}
