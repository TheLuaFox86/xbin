local bitx = require "bitx"
local xb16 = require "xb16"
local xbmc = require "xbmc"
local lfte8 = require "lfte8"
local xbci = bitx.objects.xbci(3)
local term = ""
xbci:add({
    SST = function(_r, _b, port, ...)
        if port == 0 then
            for _,v in ipairs({...}) do
                io.write(lfte8.chars[v])
                --term = term .. lfte8.chars[v]
            end
            --os.execute('clear')
            --print(term)
            return _r, _b
        end
    end,
    RST = function(_r, _b, port, ramp, si)
        local a = io.read("*line")
        local ram = _r
        for i=0, #a - 1 do
            ram[ramp][i + si] = lfte8.chars[a:sub(i + 1, i + 1)]
        end
        return ram, _b
    end
}, 6, 0)
local i = 0
local vm = xb16.new(function(mode, ...)
if mode == "xbci" then
    return xbci
elseif mode == 'goback' then
    local a = ...
    i = i - (a + 1)
end
end, bitx.objects.ram(16, 1024, 16), bitx.objects.cpureg(36))
local str = require "bootcode"
boot = bitx.split(str, "\n")
while #boot >= i do
    i = i + 1
    local a = bitx.split(boot[i], " ")
    local b = {}
    for d=1, #a do
        table.insert(b, a[d])
    end
    vm(table.unpack(b, 1, #b))
end