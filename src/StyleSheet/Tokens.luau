--!strict

local TOKENS: { [string]: Color3 } = table.freeze({
	["color-slate-50"] = Color3.fromHex("F8FAFC"),
})

local function apply(sheet: StyleSheet)
	for name, value in TOKENS do
		sheet:SetAttribute(name, value)
	end
end

return table.freeze({
	apply = apply,
	TOKENS = TOKENS,
})
