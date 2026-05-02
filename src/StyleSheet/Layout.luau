--!strict

export type Registrar = (sheet: StyleSheet) -> ()

local function rule(selector: string, props: { [string]: any }): Registrar
	return function(sheet: StyleSheet)
		local styleRule = Instance.new("StyleRule")
		styleRule.Selector = selector
		styleRule:SetProperties(props)
		styleRule.Parent = sheet
	end
end

local Z_INDICES: { [string]: number } = table.freeze({
	["z-0"] = 0,
	["z-10"] = 10,
	["z-20"] = 20,
	["z-30"] = 30,
	["z-40"] = 40,
	["z-50"] = 50,
})

local RULES: { [string]: Registrar } = {}

for tag, z in Z_INDICES do
	RULES[tag] = rule(`.{tag}`, { ZIndex = z })
end

return table.freeze({
	RULES = table.freeze(RULES),
	Z_INDICES = Z_INDICES,
})
