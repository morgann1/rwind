--!strict

local Sizing = require("@self/Sizing")

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

local ANCHORS: { [string]: Vector2 } = table.freeze({
	["origin-tl"] = Vector2.new(0, 0),
	["origin-t"] = Vector2.new(0.5, 0),
	["origin-tr"] = Vector2.new(1, 0),
	["origin-l"] = Vector2.new(0, 0.5),
	["origin-center"] = Vector2.new(0.5, 0.5),
	["origin-r"] = Vector2.new(1, 0.5),
	["origin-bl"] = Vector2.new(0, 1),
	["origin-b"] = Vector2.new(0.5, 1),
	["origin-br"] = Vector2.new(1, 1),
})

local AUTOMATIC_SIZES: { [string]: Enum.AutomaticSize } = table.freeze({
	["auto-none"] = Enum.AutomaticSize.None,
	["auto-x"] = Enum.AutomaticSize.X,
	["auto-y"] = Enum.AutomaticSize.Y,
	["auto-xy"] = Enum.AutomaticSize.XY,
})

local RULES: { [string]: Registrar } = {}

for tag, z in Z_INDICES do
	RULES[tag] = rule(`.{tag}`, { ZIndex = z })
end

for tag, anchor in ANCHORS do
	RULES[tag] = rule(`.{tag}`, { AnchorPoint = anchor })
end

for tag, mode in AUTOMATIC_SIZES do
	RULES[tag] = rule(`.{tag}`, { AutomaticSize = mode })
end

RULES["hidden"] = rule(".hidden", { Visible = false })
RULES["visible"] = rule(".visible", { Visible = true })
RULES["block"] = rule(".block", { Visible = true })

RULES["overflow-hidden"] = rule(".overflow-hidden", { ClipsDescendants = true })
RULES["overflow-visible"] = rule(".overflow-visible", { ClipsDescendants = false })

for suffix, offset in Sizing.OFFSETS do
	local pos = `pos-{suffix}`
	RULES[pos] = rule(`.{pos}`, { Position = UDim2.fromOffset(offset, offset) })

	local left = `left-{suffix}`
	RULES[left] = rule(`.{left}`, { Position = UDim2.fromOffset(offset, 0) })

	local top = `top-{suffix}`
	RULES[top] = rule(`.{top}`, { Position = UDim2.fromOffset(0, offset) })
end

for suffix, scale in Sizing.SCALES do
	local pos = `pos-{suffix}`
	RULES[pos] = rule(`.{pos}`, { Position = UDim2.fromScale(scale, scale) })

	local left = `left-{suffix}`
	RULES[left] = rule(`.{left}`, { Position = UDim2.fromScale(scale, 0) })

	local top = `top-{suffix}`
	RULES[top] = rule(`.{top}`, { Position = UDim2.fromScale(0, scale) })
end

return table.freeze({
	RULES = table.freeze(RULES),
	Z_INDICES = Z_INDICES,
	ANCHORS = ANCHORS,
	AUTOMATIC_SIZES = AUTOMATIC_SIZES,
})
