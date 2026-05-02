--!strict

local Palette = require("@self/Palette")

export type Registrar = (sheet: StyleSheet) -> ()

local function rule(selector: string, props: { [string]: any }): Registrar
	return function(sheet: StyleSheet)
		local styleRule = Instance.new("StyleRule")
		styleRule.Selector = selector
		styleRule:SetProperties(props)
		styleRule.Parent = sheet
	end
end

local CORNER_RADII: { [string]: UDim } = table.freeze({
	["rounded-none"] = UDim.new(0, 0),
	["rounded-sm"] = UDim.new(0, 2),
	["rounded"] = UDim.new(0, 4),
	["rounded-md"] = UDim.new(0, 6),
	["rounded-lg"] = UDim.new(0, 8),
	["rounded-xl"] = UDim.new(0, 12),
	["rounded-2xl"] = UDim.new(0, 16),
	["rounded-3xl"] = UDim.new(0, 24),
	["rounded-full"] = UDim.new(0.5, 0),
})

local BORDER_WIDTHS: { [string]: number } = table.freeze({
	["border-0"] = 0,
	["border"] = 1,
	["border-2"] = 2,
	["border-4"] = 4,
	["border-8"] = 8,
})

local RING_WIDTHS: { [string]: number } = table.freeze({
	["ring-0"] = 0,
	["ring-1"] = 1,
	["ring-2"] = 2,
	["ring"] = 3,
	["ring-4"] = 4,
	["ring-8"] = 8,
})

local RULES: { [string]: Registrar } = {}

for tag, radius in CORNER_RADII do
	RULES[tag] = rule(`.{tag}::UICorner`, { CornerRadius = radius })
end

for tag, width in BORDER_WIDTHS do
	RULES[tag] = rule(`.{tag}::UIStroke`, { Thickness = width })
end

for tag, width in RING_WIDTHS do
	RULES[tag] = rule(`.{tag}::UIStroke`, {
		Thickness = width,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	})
end

for hue, palette in Palette.PALETTE do
	for shade, color in palette do
		local borderTag = `border-{hue}-{shade}`
		RULES[borderTag] = rule(`.{borderTag}::UIStroke`, { Color = color })
		local ringTag = `ring-{hue}-{shade}`
		RULES[ringTag] = rule(`.{ringTag}::UIStroke`, {
			Color = color,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		})
	end
end

RULES["border-white"] = rule(".border-white::UIStroke", { Color = Palette.WHITE })
RULES["border-black"] = rule(".border-black::UIStroke", { Color = Palette.BLACK })
RULES["ring-white"] = rule(".ring-white::UIStroke", {
	Color = Palette.WHITE,
	ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
})
RULES["ring-black"] = rule(".ring-black::UIStroke", {
	Color = Palette.BLACK,
	ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
})

return table.freeze({
	RULES = table.freeze(RULES),
	CORNER_RADII = CORNER_RADII,
	BORDER_WIDTHS = BORDER_WIDTHS,
	RING_WIDTHS = RING_WIDTHS,
})
