enc = require "XBMC"
local path = arg[1]
print(path .. "\n")
local dat = ""
do
	local f = io.open(path, "r")
	dat = f:read("*a")
	f:flush()
	f:close()
end
print("---    From    ---")
print(dat)
local out = ""
for i=1, #dat do
	out = out .. enc.chars[dat:sub(i, i)] .. " "
end
f = io.open(path:sub(1, #path - 4) .. ".xbmc", "w+")
f:write(out)
f:flush()
f:close()
print("---Converted To---")
print(out)
print("\nOutput To: " .. path:sub(1, #path - 4) .. ".xbmc")
