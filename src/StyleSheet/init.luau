--!strict

local Tokens = require("@self/Tokens")

local function buildStyleSheet(): StyleSheet
	local sheet = Instance.new("StyleSheet")

	Tokens.apply(sheet)

	return sheet
end

return buildStyleSheet
