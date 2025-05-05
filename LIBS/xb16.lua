local bitx = require "bitx"
local xbmc = require "XBMC"
local xb = {}
xb.new = function(callback, _ram, _banks)
	local ram = _ram
	local banks = _banks
	local inst = {}
	inst.SXI = function(cs, bus, inst, ...)
		ram, banks = callback('xbci')[cs][bus][inst](ram, banks, ...)
	end
	inst.SB = function(value, bank)
		banks[bank] = value
	end
	inst.BOL = function(op, x, y, bank)
		local _op = ''
		local a, b = x, y
		if op == "E" then
			_OP = "=="
		elseif op == "M" then
			_op = ">"
		elseif op == "EM" then
			_op = ">="
		elseif op == "L" then
			_op = "<"
		elseif op == "EL" then
			_op = "<="
		elseif op == "N" then
			_op = "~="
		end
		banks[bank] = bitx.frombool(load('return ' .. x .. _op .. y)())
	end
	inst.GBL = function(times)
		callback('goback', times)
	end
	inst.BFR = function(part)
		callback("boot", ram[part])
	end
	inst.BFX = function(cs, bus)
		callback("boot", callback('xbci')[bus][cs].boot)
	end
	inst.IF = function(bool, ei)
		if bitx.tobool(bool) == true then
			callback("runblock", ei)
		else
			callback('goforw', ei)
		end
	end
	inst.CRY = function()
		error("VM CRY", 0)
	end
	return function(_inst, ...)
		local vals = {}
		for _, v in ipairs({...}) do
			if v:sub(1, 1) == "#" then
				table.insert(vals, banks[tonumber(v:sub(2, #v))])
			else
				local a = ""
				if tonumber(v) == nil then
					a = v
				else
					a = tonumber(v)
				end
				table.insert(vals, a)
			end
		end
		inst[_inst](table.unpack(vals, 1, #vals))
	end
end
return xb
