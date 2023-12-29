local os = require('os')
local now = os.date('*t')
local half_year = math.floor((now.month + 5) / 6)
local formatted_string = string.format("%d%02d%02d%02d%02d%02d", half_year, now.month, now.day, now.hour, now.min, now.sec)

local file = io.open("latest_build_time.txt", "w")
file:write(formatted_string)
file:close()