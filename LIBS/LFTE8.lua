local _chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 \n#-_abcdefghijklmnopqrstuvwxyz@.()[]{}<>/\\+=&%$©|•," .. '"' .. "'?~:;	"
local out = {}
out.name = "LFTE8"
out.chars = {}
for i=1, #_chars do
	out.chars[_chars:sub(i, i)] = i
	out.chars[i] = _chars:sub(i, i)
end
return out
