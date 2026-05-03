--!strict

local fs = require("@lute/fs")

local step = require("@lib/step")

local SOURCEMAP = "sourcemap.json"
local PROJECT = "dev.project.json"
local PACKAGE_DIRS = { "Packages", "DevPackages", "ServerPackages" }

local function main()
	step("wally install", { "wally", "install" })
	step("rojo sourcemap", { "rojo", "sourcemap", PROJECT, "--output", SOURCEMAP })

	for _, dir in PACKAGE_DIRS do
		if fs.exists(dir) then
			step(`wally-package-types ({dir})`, {
				"wally-package-types",
				"--sourcemap",
				SOURCEMAP,
				dir,
			})
		end
	end
end

main()
