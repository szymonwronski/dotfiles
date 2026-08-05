return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		skip_confirm_for_simple_edits = true,
		prompt_save_on_select_new_entry = false,
	},
	keys = {
		{ "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
	},
	dependencies = { { "nvim-mini/mini.icons", opts = {} } },
	lazy = false,
	config = function(_, opts)
		require("oil").setup(opts)
	end,
}
