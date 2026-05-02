--!strict

local fs = require("@lute/fs")
local io = require("@lute/io")
local process = require("@lute/process")

local SOURCEMAP = "sourcemap.json"
local PROJECT = "dev.project.json"
local PACKAGE_DIRS = { "Packages", "DevPackages", "ServerPackages" }

local function step(label: string, args: { string })
	io.write(`-> {label}\n`)
	local result = process.run(args, { stdio = "inherit" })
	if not result.ok then
		io.write(`{label} failed (exit {result.exitcode})\n`)
		process.exit(result.exitcode)
		error("unreachable")
	end
end

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
