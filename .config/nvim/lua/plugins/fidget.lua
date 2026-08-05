return {
	"j-hui/fidget.nvim",
	opts = {
		notification = {
			override_vim_notify = true,
		},
	},
	config = function(_, opts)
		require("fidget").setup(opts)
	end,
}
