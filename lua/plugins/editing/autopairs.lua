return {
	"windwp/nvim-autopairs",
	version = "*",

	event = "InsertEnter",
	opts = {},
	config = function(_, opts)
        local r = require
		local npairs = r("nvim-autopairs")
		local Rule = r("nvim-autopairs.rule")

		npairs.setup(opts)
		npairs.add_rules({
			-- Rule("<", ">")
			-- 	:with_pair(function(opts)
			-- 		return true
			-- 	end)
			-- 	:replace_endpair(function(opts)
			-- 		return ">"
			-- 	end)
			-- 	:set_end_pair_length(1),
		})
	end,
}
