local cal = sbar.add("item", {
	icon = {
		padding_right = 0,
		font = {
			family = "JetBrainsMono Nerd Font",
			style = "ExtraBold",
			size = 13.0,
		},
		-- font = "JetBrainsMono Nerd Font:ExtraBold:13.0",
	},
	label = {
		width = 70,
		align = "right",
	},
	position = "right",
	update_freq = 15,
})

local function update()
	local date = os.date("%a %b %d")

	---@diagnostic disable-next-line
	local time = os.date("%I:%M %p"):gsub("^0", "")
	-- local time = "12:20 PM"

	cal:set({ icon = date, label = time })
end

cal:subscribe("routine", update)
cal:subscribe("forced", update)
