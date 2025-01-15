require("full-border"):setup({
	-- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
	type = ui.Border.ROUNDED,
})
require("git"):setup()
-- Global cache table
local dir_size_cache = {}
-- Function to get directory size
local function get_directory_size(dir)
	-- Use cached value if available
	if dir_size_cache[dir] then
		return dir_size_cache[dir]
	else
		-- Otherwise, calculate and cache it
		local handle = io.popen("sudo du -sb " .. dir .. " 2>/dev/null | cut -f1")
		if not handle then
			return nil
		end
		local result = handle:read("*a")
		handle:close()
		local size = tonumber(result)
		dir_size_cache[dir] = size
		return size
	end
end
-- Function to format modification time
local function format_time(time)
	if time == 0 then
		return ""
	elseif os.date("%Y", time) == os.date("%Y") then
		return os.date("%b %d %H:%M", time)
	else
		return os.date("%b %d  %Y", time)
	end
end
function Linemode:lineui()
	local time = math.floor(self._file.cha.mtime or 0)
	local size = 0
	-- Format the modification time
	time = format_time(time)
	if self._file.cha.is_dir then
		size = get_directory_size(self._file.url .. "")
	else
		size = self._file:size()
	end
	-- Return the formatted line
	return ui.Line(string.format("%s %s", size and ya.readable_size(size) or "-", time))
end
