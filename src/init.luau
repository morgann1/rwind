--!strict

local StyleSheet = require("@self/StyleSheet")

local function capitalize(text: string): string
	local result = string.gsub(text, "%a[%w']*", function(word)
		local first = string.sub(word, 1, 1)
		local rest = string.sub(word, 2)
		return `{string.upper(first)}{string.lower(rest)}`
	end)
	return result
end

local TRANSFORMS: { [string]: ((string) -> string)? } = {
	["uppercase"] = string.upper,
	["lowercase"] = string.lower,
	["capitalize"] = capitalize,
}

local DECORATIONS: { [string]: { open: string, close: string }? } = {
	["underline"] = { open = "<u>", close = "</u>" },
	["line-through"] = { open = "<s>", close = "</s>" },
}

local function decorate(text: string, classes: string): string
	local result = text
	for class in string.gmatch(classes, "%S+") do
		local transform = TRANSFORMS[class]
		if transform ~= nil then
			result = transform(result)
		end
	end
	for class in string.gmatch(classes, "%S+") do
		local decoration = DECORATIONS[class]
		if decoration ~= nil then
			result = `{decoration.open}{result}{decoration.close}`
		end
	end
	return result
end

return table.freeze({
	install = StyleSheet.install,
	mount = StyleSheet.mount,
	rw = StyleSheet.rw,
	decorate = decorate,
})
