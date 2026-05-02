local TOKENS = table.freeze({})

local function apply(sheet: StyleSheet)
	for name, value in TOKENS do
		sheet:SetAttribute(name, value)
	end
end

return table.freeze({
	apply = apply,
	TOKENS = TOKENS,
})
