--!strict

local fs = require("@lute/fs")
local net = require("@lute/net")

local step = require("@lib/step")

local SOURCEMAP = "sourcemap.json"
local PROJECT = "dev.project.json"
local SOURCE_DIR = "src"
local CACHE_DIR = ".lute/cache"
local DEFINITIONS = `{CACHE_DIR}/globalTypes.d.luau`
local DEFINITIONS_URL =
	"https://raw.githubusercontent.com/JohnnyMorganz/luau-lsp/main/scripts/globalTypes.d.luau"

local function writeFile(path: string, contents: string)
	local handle = fs.open(path, "w")
	fs.write(handle, contents)
	fs.close(handle)
end

local function ensureDefinitions()
	if fs.exists(DEFINITIONS) then
		return
	end
	if not fs.exists(CACHE_DIR) then
		fs.mkdir(CACHE_DIR)
	end
	local response = net.client.request(DEFINITIONS_URL)
	assert(response.ok, `Failed to fetch Roblox type definitions (status {response.status})`)
	writeFile(DEFINITIONS, response.body)
end

local function main()
	ensureDefinitions()
	step("rojo sourcemap", { "rojo", "sourcemap", PROJECT, "--output", SOURCEMAP })
	step("selene", { "selene", SOURCE_DIR })
	step("luau-lsp analyze", {
		"luau-lsp",
		"analyze",
		`--sourcemap={SOURCEMAP}`,
		`--definitions={DEFINITIONS}`,
		"--platform=roblox",
		"--no-strict-dm-types",
		SOURCE_DIR,
	})
end

main()
