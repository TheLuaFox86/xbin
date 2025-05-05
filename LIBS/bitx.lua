local bitx = {}
bitx.calcbit = function(bit)
	local a = 2
	for _=1, bit do
		a = a * 2
	end
	return a
end
bitx.newint = function(bits, ...)
	local byte = {}
	for i,v in ipairs({...}) do
		if v > bitx.calcbit(bits) then
			error("value " .. i .. "Is To Big, must be a max of " .. bitx.calcbit(bits) .. " got " .. v)
		end
		byte[i] = v
	end
	return {bit=bits, mode="int", values=byte}
end
bitx.tobool = function(val)
	if val == "-" or val == 40 then
		return true
	else
		return false
	end
end
bitx.frombool = function(bool)
	if bool == true then
		return 40, "-"
	else
		return 41, "_"
	end
end
bitx.parsevals = function(txt)
	local out = {}
	local c = 0
	for v in txt:gmatch("%S+") do
		c = c + 1
		out[c] = tonumber(v)
	end
	return out
end
bitx.split = function(txt, del)
	local out = {}
	local c = 0
	local a = ""
	i = 0
	for _=1, #txt do
		i = i + 1
		if txt:sub(i , i + (#del - 1)) == del then
			c = c + 1
			out[c] = a
			a = ""
			i = i + (#del - 1)
		else
			--print(txt:sub(i, i + (#del - 1)))
			a = a .. txt:sub(i, i)
		end
	end
	out[c + 1] = a
	return out
end
bitx.objects = {
	ram = function(bits, size, parts)
		local a = {}
		for i=1, parts do
			local b = {}
			for d=1, size do
				b[d] = 0
			end
			a[i] = bitx.newint(bits, table.unpack(b, 1, b.n))
		end
		return a
	end,
	cpureg = function(amount)
		local a = {}
		for i=1, amount do
			a[i] = 0
		end
		return a
	end
}
return bitx
