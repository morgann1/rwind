--!strict

local fs = require("@lute/fs")
local io = require("@lute/io")
local process = require("@lute/process")

local EXAMPLES_DIR = "examples"
local PROJECT_FILE = "place.project.json"
local OUTPUT_FILE = "place.rbxl"

type Example = { name: string, project: string }

local function findExamples(): { Example }
	local out: { Example } = {}
	if not fs.exists(EXAMPLES_DIR) then
		return out
	end

	for _, entry in fs.listdir(EXAMPLES_DIR) do
		if entry.type ~= "dir" then
			continue
		end
		local project = `{EXAMPLES_DIR}/{entry.name}/{PROJECT_FILE}`
		if fs.exists(project) then
			table.insert(out, { name = entry.name, project = project })
		end
	end

	table.sort(out, function(a, b)
		return a.name < b.name
	end)
	return out
end

local function pick(examples: { Example }): Example
	local requested = process.args[2]
	if requested then
		for _, ex in examples do
			if ex.name == requested then
				return ex
			end
		end
		io.write(`No example named "{requested}". Available:\n`)
		for _, ex in examples do
			io.write(`  {ex.name}\n`)
		end
		process.exit(1)
	end

	io.write("Select an example to build:\n")
	for i, ex in examples do
		io.write(`  [{i}] {ex.name}\n`)
	end
	io.write("> ")

	local input = io.read()
	local idx = tonumber(input)
	if idx then
		local picked = examples[idx]
		if picked then
			return picked
		end
	end
	io.write(`Invalid selection: {input}\n`)
	process.exit(1)
	error("unreachable")
end

local function main()
	local examples = findExamples()
	if #examples == 0 then
		io.write(`No examples found under {EXAMPLES_DIR}/. Add a folder containing {PROJECT_FILE}.\n`)
		process.exit(1)
	end

	local picked = pick(examples)
	io.write(`Building {picked.name} -> {OUTPUT_FILE}\n`)

	local result = process.run({
		"rojo",
		"build",
		picked.project,
		"--output",
		OUTPUT_FILE,
	}, { stdio = "inherit" })

	if not result.ok then
		io.write(`rojo build failed (exit {result.exitcode})\n`)
		process.exit(result.exitcode)
	end
end

main()
