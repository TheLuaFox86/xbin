local xba = {}
local lfs = require "lfs"
function xba.new(script, globalmods, localmods ...)
    local txt, rxbn = '', ''
    _G.part = {}
    _G.board = {}
    _G.add = function(...)
        for _, dat in ipairs({...}) do
            txt = txt .. dat .. "\n"
        end
    end
    _G.ins = function(...)
        local a = ""
        for d in ipairs({...}) do
            a = a .. d .. " "
        end
        a = a:sub(1, #a - 1)
        return a
    end
    local function loadm(path, var)
        local a = {}
        for f in lfs.list(path) do
            if f ~= "." or ~= ".." then
                _, a = loadfile(path .. "/" .. f, 't', _G)
                _G[var][f] = a
            end
        end
    end
    loadm(globalmods .. "/parts", 'part')
    loadm(globalmods .. "/boards", 'board')
    loadm(localmods .. "/parts", 'part')
    loadm(localmods .. "/boards", 'board')
    return txt, rxbn
end