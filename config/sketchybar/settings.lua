return {
	paddings = 4,
	group_paddings = 10,
	icon = {
		padding_left = 10,
		padding_right = 10,
	},
	label = {
		padding_left = 10,
		padding_right = 10,
	},

	icons = "sf-symbols", -- alternatively available: NerdFont

	-- This is a font configuration for SF Pro and SF Mono (installed manually)
	font = require("helpers.default_font"),

	-- Alternatively, this is a font config for JetBrainsMono Nerd Font
	-- font = {
	-- 	text = "BerkeleyMono Nerd Font", -- Used for text
	-- 	numbers = "BerkeleyMono Nerd Font", -- Used for numbers
	-- 	style_map = {
	-- 		["Regular"] = "Regular",
	-- 		-- ["Semibold"] = "Medium",
	-- 		-- ["Bold"] = "SemiBold",
	-- 		["Bold"] = "Bold",
	-- 		-- ["Black"] = "ExtraBold",
	-- 	},
	-- },
}
