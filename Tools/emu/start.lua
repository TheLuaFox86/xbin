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
                term = term .. lfte8.chars[v]
            end
            os.execute('clear')
            print(term)
            return _r, _b
        end
    end,
}, 6, 0)
local i = 0
local vm = xb16.new(function(mode, ...)
if mode == "xbci" then
    return xbci
end
end, bitx.objects.ram(16, 1024, 16), bitx.objects.cpureg(36))
local str = require "bootcode"
boot = bitx.split(str, "\n")
for _=1, #boot do
    i = i + 1
    local a = bitx.split(boot[i], " ")
    local b = {}
    for d=1, #a do
        table.insert(b, a[d])
    end
    vm(table.unpack(b, 1, #b))
end