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

type ShadowSpec = { offset: UDim2, blur: UDim, transparency: number }

local SHADOWS: { [string]: ShadowSpec } = table.freeze({
	["shadow-none"] = {
		offset = UDim2.new(),
		blur = UDim.new(),
		transparency = 1,
	},
	["shadow-sm"] = {
		offset = UDim2.fromOffset(0, 1),
		blur = UDim.new(0, 2),
		transparency = 0.95,
	},
	["shadow"] = {
		offset = UDim2.fromOffset(0, 1),
		blur = UDim.new(0, 3),
		transparency = 0.9,
	},
	["shadow-md"] = {
		offset = UDim2.fromOffset(0, 4),
		blur = UDim.new(0, 6),
		transparency = 0.9,
	},
	["shadow-lg"] = {
		offset = UDim2.fromOffset(0, 10),
		blur = UDim.new(0, 15),
		transparency = 0.9,
	},
	["shadow-xl"] = {
		offset = UDim2.fromOffset(0, 20),
		blur = UDim.new(0, 25),
		transparency = 0.9,
	},
	["shadow-2xl"] = {
		offset = UDim2.fromOffset(0, 25),
		blur = UDim.new(0, 50),
		transparency = 0.75,
	},
})

local RULES: { [string]: Registrar } = {}

for tag, spec in SHADOWS do
	RULES[tag] = rule(`.{tag}::UIShadow`, {
		Offset = spec.offset,
		BlurRadius = spec.blur,
		Transparency = spec.transparency,
	})
end

for hue, palette in Palette.PALETTE do
	for shade, color in palette do
		local tag = `shadow-{hue}-{shade}`
		RULES[tag] = rule(`.{tag}::UIShadow`, { Color = color })
	end
end

RULES["shadow-white"] = rule(".shadow-white::UIShadow", { Color = Palette.WHITE })
RULES["shadow-black"] = rule(".shadow-black::UIShadow", { Color = Palette.BLACK })

return table.freeze({
	RULES = table.freeze(RULES),
	SHADOWS = SHADOWS,
})
