local lb = require "LuaBin"
local path, mode = ...
local ch = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
local xba = {}
xba.aluinput = {}
local len = 0
for i=1, #ch do
  xba.aluinput[ch:sub(i, i)] = i
  xba.aluinput[i] = ch:sub(i, i)
  len = i
end
xba.aluinput[" "] = len + 1
xba.aluinput["\n"] = len + 2
xba.aluinput["#"] = len + 3
xba.c = {}
local out = {}
--compiler--
xba.c.classic = function(str)
  local com = 0
  for i=1, #str do
    print("(" .. str:sub(i, i) .. "): ", com)
    if str:sub(i, i) == "[" then
			com = 1
    end
    if str:sub(i, i) == "]" then
      com = 0
    end
    if com == 0 then
      print(xba.aluinput[str:sub(i, i)])
    		table.insert(out, xba.aluinput[str:sub(i, i)])
		end
  end
end
--file reader--
local f = io.open(path, "r")
xba.c[mode](f:read("*a"))
f:flush()
f:close()
--converter--
--to .xbn
local output2 = lb.open(path .. ".xbin", "w")
local output = io.open(path .. ".xbn", "w+")
local buffer = ""
for _, n in ipairs(out) do
	print(n)
	buffer = buffer .. tostring(n) .. "\n"
	lb.writeInt16(output2, n)
end
output:write(buffer)
output:flush()
output:close()
