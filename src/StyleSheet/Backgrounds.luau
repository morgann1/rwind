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

local OPACITIES: { number } = table.freeze({
	0,
	5,
	10,
	20,
	25,
	30,
	40,
	50,
	60,
	70,
	75,
	80,
	90,
	95,
	100,
})

local RULES: { [string]: Registrar } = {}

for hue, palette in Palette.PALETTE do
	for shade, color in palette do
		local tag = `bg-{hue}-{shade}`
		RULES[tag] = rule(`.{tag}`, { BackgroundColor3 = color })
	end
end

RULES["bg-white"] = rule(".bg-white", { BackgroundColor3 = Palette.WHITE })
RULES["bg-black"] = rule(".bg-black", { BackgroundColor3 = Palette.BLACK })
RULES["bg-transparent"] = rule(".bg-transparent", { BackgroundTransparency = 1 })

for _, opacity in OPACITIES do
	local tag = `bg-opacity-{opacity}`
	RULES[tag] = rule(`.{tag}`, { BackgroundTransparency = 1 - opacity / 100 })
end

return table.freeze({
	RULES = table.freeze(RULES),
})
