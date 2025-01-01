local settings = require("settings")
local colors = require("colors")

-- Padding item required because of bracket
sbar.add("item", { position = "right", width = settings.group_paddings })

local cal = sbar.add("item", {
	icon = {
		font = {
			size = 13.0,
			family = "MesloLGS Nerd Font Mono",
			style = "Bold"
		},
	},
	label = {
		width = 45,
		align = "right",
		font = {
			size = 13.0,
			family = "MesloLGS Nerd Font Mono",
			style = "Bold"
		},
	},
	position = "right",
	update_freq = 30,
})

cal:subscribe({ "forced", "routine", "system_woke" }, function(env)
	cal:set({ icon = os.date("%a %d %b"), label = os.date("%H:%M") })
end)
