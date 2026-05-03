--!strict

local io = require("@lute/io")
local process = require("@lute/process")

local function step(label: string, args: { string })
	io.write(`-> {label}\n`)
	local result = process.run(args, { stdio = "inherit" })
	if not result.ok then
		io.write(`{label} failed (exit {result.exitcode})\n`)
		process.exit(result.exitcode)
		error("unreachable")
	end
end

return step
