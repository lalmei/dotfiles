local mocha = {
    name = "mocha",
    rosewater = {
        hex = "#f5e0dc",
        rgb = { 245, 224, 220 },
        hsl = { 10, 0.56, 0.91 },
    },
    flamingo = {
        hex = "#f2cdcd",
        rgb = { 242, 205, 205 },
        hsl = { 0, 0.59, 0.88 },
    },
    pink = {
        hex = "#f5c2e7",
        rgb = { 245, 194, 231 },
        hsl = { 316, 0.72, 0.86 },
    },
    mauve = {
        hex = "#cba6f7",
        rgb = { 203, 166, 247 },
        hsl = { 267, 0.84, 0.81 },
    },
    red = {
        hex = "#f38ba8",
        rgb = { 243, 139, 168 },
        hsl = { 343, 0.81, 0.75 },
    },
    maroon = {
        hex = "#eba0ac",
        rgb = { 235, 160, 172 },
        hsl = { 350, 0.65, 0.77 },
    },
    peach = {
        hex = "#fab387",
        rgb = { 250, 179, 135 },
        hsl = { 23, 0.92, 0.75 },
    },
    yellow = {
        hex = "#f9e2af",
        rgb = { 249, 226, 175 },
        hsl = { 41, 0.86, 0.83 },
    },
    green = {
        hex = "#a6e3a1",
        rgb = { 166, 227, 161 },
        hsl = { 115, 0.54, 0.76 },
    },
    teal = {
        hex = "#94e2d5",
        rgb = { 148, 226, 213 },
        hsl = { 170, 0.57, 0.73 },
    },
    sky = {
        hex = "#89dceb",
        rgb = { 137, 220, 235 },
        hsl = { 189, 0.71, 0.73 },
    },
    sapphire = {
        hex = "#74c7ec",
        rgb = { 116, 199, 236 },
        hsl = { 199, 0.76, 0.69 },
    },
    blue = {
        hex = "#89b4fa",
        rgb = { 137, 180, 250 },
        hsl = { 217, 0.92, 0.76 },
    },
    lavender = {
        hex = "#b4befe",
        rgb = { 180, 190, 254 },
        hsl = { 232, 0.97, 0.85 },
    },
    text = {
        hex = "#cdd6f4",
        rgb = { 205, 214, 244 },
        hsl = { 226, 0.64, 0.88 },
    },
    subtext1 = {
        hex = "#bac2de",
        rgb = { 186, 194, 222 },
        hsl = { 227, 0.35, 0.80 },
    },
    subtext0 = {
        hex = "#a6adc8",
        rgb = { 166, 173, 200 },
        hsl = { 228, 0.24, 0.72 },
    },
    overlay2 = {
        hex = "#9399b2",
        rgb = { 147, 153, 178 },
        hsl = { 228, 0.17, 0.64 },
    },
    overlay1 = {
        hex = "#7f849c",
        rgb = { 127, 132, 156 },
        hsl = { 230, 0.13, 0.55 },
    },
    overlay0 = {
        hex = "#6c7086",
        rgb = { 108, 112, 134 },
        hsl = { 231, 0.11, 0.47 },
    },
    surface2 = {
        hex = "#585b70",
        rgb = { 88, 91, 112 },
        hsl = { 233, 0.12, 0.39 },
    },
    surface1 = {
        hex = "#45475a",
        rgb = { 69, 71, 90 },
        hsl = { 234, 0.13, 0.31 },
    },
    surface0 = {
        hex = "#313244",
        rgb = { 49, 50, 68 },
        hsl = { 237, 0.16, 0.23 },
    },
    base = {
        hex = "#1e1e2e",
        rgb = { 30, 30, 46 },
        hsl = { 240, 0.21, 0.15 },
    },
    mantle = {
        hex = "#181825",
        rgb = { 24, 24, 37 },
        hsl = { 240, 0.21, 0.12 },
    },
    crust = {
        hex = "#11111b",
        rgb = { 17, 17, 27 },
        hsl = { 240, 0.23, 0.09 },
    },
}
local hexToBase16 = function(hex)
    -- Remove the '#' character if it exists
    hex = hex:gsub('#', '')

    -- If it's a 6-digit color (RGB), append 'ff' for fully opaque alpha
    if #hex == 6 then
        hex = 'ff' .. hex
    end

    -- Convert hex to a base-16 number and return it as a number
    return tonumber(hex, 16)
end

local convertAllColorsToBase16 = function(colors)
    for colorName, colorData in pairs(colors) do
        -- Convert the hex value to base-16 and add it as an attribute
        if colorData.hex then
            colorData.base16 = hexToBase16(colorData.hex)
        end
    end
end

-- Convert all colors in the 'mocha' palette
convertAllColorsToBase16(mocha)

return mocha
