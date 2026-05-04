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

local OFFSETS: { [string]: number } = table.freeze({
	["0"] = 0,
	["px"] = 1,
	["0.5"] = 2,
	["1"] = 4,
	["1.5"] = 6,
	["2"] = 8,
	["2.5"] = 10,
	["3"] = 12,
	["3.5"] = 14,
	["4"] = 16,
	["5"] = 20,
	["6"] = 24,
	["7"] = 28,
	["8"] = 32,
	["9"] = 36,
	["10"] = 40,
	["11"] = 44,
	["12"] = 48,
	["14"] = 56,
	["16"] = 64,
	["20"] = 80,
	["24"] = 96,
	["28"] = 112,
	["32"] = 128,
	["36"] = 144,
	["40"] = 160,
	["44"] = 176,
	["48"] = 192,
	["52"] = 208,
	["56"] = 224,
	["60"] = 240,
	["64"] = 256,
	["72"] = 288,
	["80"] = 320,
	["96"] = 384,
})

local SCALES: { [string]: number } = table.freeze({
	["1/2"] = 1 / 2,
	["1/3"] = 1 / 3,
	["2/3"] = 2 / 3,
	["1/4"] = 1 / 4,
	["2/4"] = 2 / 4,
	["3/4"] = 3 / 4,
	["1/5"] = 1 / 5,
	["2/5"] = 2 / 5,
	["3/5"] = 3 / 5,
	["4/5"] = 4 / 5,
	["1/6"] = 1 / 6,
	["2/6"] = 2 / 6,
	["3/6"] = 3 / 6,
	["4/6"] = 4 / 6,
	["5/6"] = 5 / 6,
	["1/12"] = 1 / 12,
	["2/12"] = 2 / 12,
	["3/12"] = 3 / 12,
	["4/12"] = 4 / 12,
	["5/12"] = 5 / 12,
	["6/12"] = 6 / 12,
	["7/12"] = 7 / 12,
	["8/12"] = 8 / 12,
	["9/12"] = 9 / 12,
	["10/12"] = 10 / 12,
	["11/12"] = 11 / 12,
	["full"] = 1,
})

local RULES: { [string]: Registrar } = {}

for suffix, offset in OFFSETS do
	local sizeTag = `size-{suffix}`
	RULES[sizeTag] = rule(`.{sizeTag}`, { Size = UDim2.fromOffset(offset, offset) })

	local widthTag = `w-{suffix}`
	RULES[widthTag] = rule(`.{widthTag}`, { Size = UDim2.fromOffset(offset, 0) })

	local heightTag = `h-{suffix}`
	RULES[heightTag] = rule(`.{heightTag}`, { Size = UDim2.fromOffset(0, offset) })
end

for suffix, scale in SCALES do
	local sizeTag = `size-{suffix}`
	RULES[sizeTag] = rule(`.{sizeTag}`, { Size = UDim2.fromScale(scale, scale) })

	local widthTag = `w-{suffix}`
	RULES[widthTag] = rule(`.{widthTag}`, { Size = UDim2.fromScale(scale, 0) })

	local heightTag = `h-{suffix}`
	RULES[heightTag] = rule(`.{heightTag}`, { Size = UDim2.fromScale(0, scale) })
end

for suffix, offset in OFFSETS do
	local minW = `min-w-{suffix}`
	RULES[minW] = rule(`.{minW}::UISizeConstraint`, { MinSize = Vector2.new(offset, 0) })

	local minH = `min-h-{suffix}`
	RULES[minH] = rule(`.{minH}::UISizeConstraint`, { MinSize = Vector2.new(0, offset) })

	local maxW = `max-w-{suffix}`
	RULES[maxW] = rule(`.{maxW}::UISizeConstraint`, { MaxSize = Vector2.new(offset, math.huge) })

	local maxH = `max-h-{suffix}`
	RULES[maxH] = rule(`.{maxH}::UISizeConstraint`, { MaxSize = Vector2.new(math.huge, offset) })
end

return table.freeze({
	RULES = table.freeze(RULES),
	OFFSETS = OFFSETS,
	SCALES = SCALES,
})
