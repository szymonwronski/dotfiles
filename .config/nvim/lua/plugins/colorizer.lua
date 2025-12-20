return {
	"norcalli/nvim-colorizer.lua",
	opts = {
		css = true,
	},
	config = function()
		require("colorizer").setup()
	end,
}
