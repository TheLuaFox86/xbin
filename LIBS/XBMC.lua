local _chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 \n#-_"
local out = {}
out.name = "XBMCE"
out.chars = {}
for i=1, #_chars do
	out.chars[_chars:sub(i, i)] = i
	out.chars[i] = _chars:sub(i, i)
end
return out
