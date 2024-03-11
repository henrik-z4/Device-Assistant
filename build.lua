-- Путь к файлу build.txt
local build_number_file = 'latest_build.txt'

local build_number
local file = io.open(build_number_file, "r")
if file then
    build_number = file:read("*a")
    file:close()
    build_number = tonumber(build_number)
else
    build_number = 0
end

build_number = build_number + 1

file = io.open(build_number_file, "w")
file:write(tostring(build_number))
file:close()