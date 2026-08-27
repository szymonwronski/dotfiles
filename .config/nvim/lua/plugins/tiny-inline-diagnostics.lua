return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "VeryLazy",
	priority = 1000,
	opts = {
		preset = "minimal",
		override_open_float = true,
		options = {
			show_source = {
				"if_many",
			},
			show_code = false,
			multilines = {
				enabled = true,
				always_show = true,
			},
		},
	},
	keys = {
		{ "<leader>dt", "<cmd>TinyInlineDiag toggle<cr>", { desc = "Toggle diagnostics" } },
		{ "<leader>dc", "<cmd>TinyInlineDiag toggle_cursor_only<cr>", { desc = "Toggle cursor-only diagnostics" } },
	},
	config = function(_, opts)
		require("tiny-inline-diagnostic").setup(opts)
	end,
}
