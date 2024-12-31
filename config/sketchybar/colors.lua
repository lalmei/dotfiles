local is_dark_mode = require("is_dark_mode") == "dark"

local mocha = require("mocha")

local colors = {}
local with_alpha = function(color, alpha)
	if alpha > 1.0 or alpha < 0.0 then
		return color
	end
	return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
end
colors.with_alpha = with_alpha


local theme = {
	-- Base16 Default Dark Theme
	dark = mocha.base.base16,
	dark_grey = mocha.surface0.base16,
	grey = mocha.overlay0.base16,
	light_grey = mocha.subtext0.base16,
	dark_silver = mocha.subtext1.base16,
	silver = mocha.blue.base16,
	light_silver = mocha.sky.base16,
	light = mocha.text.base16,
	red = mocha.red.base16,
	orange = mocha.peach.base16,
	yellow = mocha.yellow.base16,
	green = mocha.green.base16,
	cyan = mocha.teal.base16,
	blue = mocha.blue.base16,
	magenta = mocha.maroon.base16,
	brown = mocha.mauve.base16,
	maroon = mocha.maroon.base16,
	mauve = mocha.mauve.base16,
	rosewater = mocha.rosewater.base16,
	teal = mocha.teal.base16,

	-- Special colors
	transparent = mocha.base.base16,
	black = mocha.base.base16,
	white = mocha.text.base16,
	github_blue = mocha.sapphire.base16,
	lavender = mocha.lavender.base16,

}

for k, v in pairs(theme) do
	colors[k] = v
end

if is_dark_mode then
	colors.fg = theme.silver
	colors.fg_highlight = theme.blue
	colors.fg_secondary = theme.silver
	colors.bg = theme.black
	colors.border = mocha.crust.base16
	-- colors.active = theme.white
	colors.active = mocha.rosewater.base16
else
	colors.fg = theme.dark
	colors.fg_highlight = theme.github_blue
	colors.fg_secondary = theme.light_grey
	colors.bg = theme.light
	colors.border = theme.silver
	colors.active = theme.white
end

return colors
