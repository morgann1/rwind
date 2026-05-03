--!strict

local step = require("@lib/step")

local SOURCEMAP = "sourcemap.json"
local PROJECT = "dev.project.json"
local SOURCE_DIR = "src"

local function main()
	step("rojo sourcemap", { "rojo", "sourcemap", PROJECT, "--output", SOURCEMAP })
	step("selene", { "selene", SOURCE_DIR })
	step("luau-lsp analyze", {
		"luau-lsp",
		"analyze",
		`--sourcemap={SOURCEMAP}`,
		"--platform=roblox",
		"--no-strict-dm-types",
		SOURCE_DIR,
	})
end

main()
