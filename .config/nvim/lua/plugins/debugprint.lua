return {
	"andrewferrier/debugprint.nvim",

	-- opts = { … },

	dependencies = {
		"nvim-mini/mini.hipatterns", -- Optional: Needed for line highlighting ('fine-grained' hipatterns plugin)
	},

	lazy = false, -- Required to make line highlighting work before debugprint is first used
	version = "*", -- Remove if you DON'T want to use the stable version
	config = function()
		require("debugprint").setup()
	end,
}
