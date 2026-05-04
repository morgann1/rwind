--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Backgrounds = require("@self/Backgrounds")
local Borders = require("@self/Borders")
local Layout = require("@self/Layout")
local Shadows = require("@self/Shadows")
local Sizing = require("@self/Sizing")
local Spacing = require("@self/Spacing")
local Typography = require("@self/Typography")

local SHEET_NAME = "rw_StyleSheet"

local _sheet: StyleSheet? = nil
local _registered: { [string]: true? } = {}

type Registrar = (sheet: StyleSheet) -> ()

local function ensure(tag: string)
	if _registered[tag] ~= nil then
		return
	end
	local registrar: Registrar? = Typography.RULES[tag]
		or Borders.RULES[tag]
		or Shadows.RULES[tag]
		or Layout.RULES[tag]
		or Backgrounds.RULES[tag]
		or Sizing.RULES[tag]
		or Spacing.RULES[tag]
	if registrar == nil then
		return
	end
	local sheet = _sheet
	if sheet == nil then
		return
	end
	registrar(sheet)
	_registered[tag] = true
end

local function findExistingSheet(parent: Instance): StyleSheet?
	local existing = parent:FindFirstChild(SHEET_NAME)
	if existing ~= nil and existing:IsA("StyleSheet") then
		return existing
	end
	return nil
end

local function buildStyleSheet(): StyleSheet
	local sheet = Instance.new("StyleSheet")
	return sheet
end

local function install(parent: Instance?): StyleSheet
	if _sheet ~= nil then
		return _sheet
	end

	local target = parent or ReplicatedStorage
	local existing = findExistingSheet(target)
	if existing ~= nil then
		_sheet = existing
		return existing
	end

	local sheet = buildStyleSheet()
	sheet.Name = SHEET_NAME
	sheet.Parent = target
	_sheet = sheet
	return sheet
end

local function mount(host: Instance, sheet: StyleSheet?): StyleLink
	local resolved = sheet or _sheet or findExistingSheet(ReplicatedStorage)
	assert(resolved ~= nil, "rwind.install must run before mount")

	local link = Instance.new("StyleLink")
	link.StyleSheet = resolved
	link.Parent = host
	return link
end

local function rw(...: string | false | nil): string
	local tags: { string } = {}
	for _, argument in { ... } do
		if type(argument) ~= "string" then
			continue
		end
		for tag in string.gmatch(argument, "%S+") do
			ensure(tag)
			table.insert(tags, tag)
		end
	end
	return table.concat(tags, " ")
end

return table.freeze({
	install = install,
	mount = mount,
	rw = rw,
})
