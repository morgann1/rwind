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

local RULES: { [string]: Registrar } = {}

for suffix, offset in Sizing.OFFSETS do
	local pad = UDim.new(0, offset)

	local all = `p-{suffix}`
	RULES[all] = rule(`.{all}::UIPadding`, {
		PaddingTop = pad,
		PaddingRight = pad,
		PaddingBottom = pad,
		PaddingLeft = pad,
	})

	local x = `px-{suffix}`
	RULES[x] = rule(`.{x}::UIPadding`, { PaddingLeft = pad, PaddingRight = pad })

	local y = `py-{suffix}`
	RULES[y] = rule(`.{y}::UIPadding`, { PaddingTop = pad, PaddingBottom = pad })

	local top = `pt-{suffix}`
	RULES[top] = rule(`.{top}::UIPadding`, { PaddingTop = pad })

	local right = `pr-{suffix}`
	RULES[right] = rule(`.{right}::UIPadding`, { PaddingRight = pad })

	local bottom = `pb-{suffix}`
	RULES[bottom] = rule(`.{bottom}::UIPadding`, { PaddingBottom = pad })

	local left = `pl-{suffix}`
	RULES[left] = rule(`.{left}::UIPadding`, { PaddingLeft = pad })

	local gap = `gap-{suffix}`
	RULES[gap] = rule(`.{gap}::UIListLayout`, { Padding = pad })
end

return table.freeze({
	RULES = table.freeze(RULES),
})
