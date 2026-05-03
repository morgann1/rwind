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

return table.freeze({
	RULES = table.freeze(RULES),
})
