local icons = require("icons")
local colors = require("colors")

local apple_logo = sbar.add("item", {
	padding_right = 15,
	icon = {
		string = icons.apple,
		font = {
			style = "Black",
			size = 16.0,
		},
		color = colors.white,
	},
	label = {
		drawing = false,
	},
	popup = {
		height = 35,
	},
})
