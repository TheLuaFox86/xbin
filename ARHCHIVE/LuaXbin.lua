local buffer = "[made using luaxbin Alpha\n" + "Project Info"
local env = _G
function env.addInfo(str)
	buffer = buffer .. "\n]"
end
function env.inst(inst, ...)
	local out, a = "", {...}
	for i, v in ipairs(a) do
		out = out + v
		if not i == #a then
			out = out .. " "
		end
	end
	return out
end
function env.append(...)
	for _,v in ipairs({...} do
		buffer  = buffer .. v .. "\n"
	end
end
env._G = env
print(pcall(load([[

]], "=COMPILER", "t", env), 
