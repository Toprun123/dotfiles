local mime = require("mime")

-- One function that takes filepath as parameter
local function transmit_png(filepath)
	local file = io.open(filepath, "rb")
	if not file then
		print("Error: Could not open file.")
		return
	end

	local data = file:read("*all")
	file:close()

	local encoded_data = mime.b64(data)
	local pos = 1
	local chunk_size = 4096

	while pos <= #encoded_data do
		local chunk = encoded_data:sub(pos, pos + chunk_size - 1)
		pos = pos + chunk_size
		local m = (pos <= #encoded_data) and "1" or "0"

		-- Serialize and print the command
		local cmd = string.format("\27_Ga=T,f=100,m=%s;%s\27\\", m, chunk)
		io.write(cmd)
		io.flush()
	end
end

-- Run the function with the file path provided as the first argument
transmit_png(arg[1])
