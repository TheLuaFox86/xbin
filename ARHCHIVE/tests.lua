local StringLib = require("luajss")

local str = " Hello, Lua! "

print(StringLib.trim(str))               -- "Hello, Lua!"
print(StringLib.toUpperCase(str))        -- " HELLO, LUA! "
print(StringLib.startsWith(str, " Hel")) -- true
print(StringLib.endsWith(str, "! "))     -- true
print(StringLib.substring(str, 2, 6))    -- "Hello"
print(StringLib.split(str, ","))         -- {" Hello", " Lua! "}
print(StringLib.replace(str, "Lua", "World")) -- " Hello, World! "
print(StringLib.repeatString("Hi ", 3))  -- "Hi Hi Hi "
print(StringLib.charAt(str, 2))          -- "H"
print(StringLib.indexOf(str, "Lua"))     -- 9
print(StringLib.includes(str, "Lua"))    -- true

local BinaryFile = require("LuaBin")

-- Writing to a binary file
local writeFile = BinaryFile.open("test.bin", "w")
BinaryFile.writeUint16(writeFile, 65535)         -- Write unsigned 16-bit integer
BinaryFile.writeInt16(writeFile, -32768)         -- Write signed 16-bit integer
BinaryFile.writeString(writeFile, "Hello")       -- Write a string
BinaryFile.close(writeFile)

-- Reading from a binary file
local readFile = BinaryFile.open("test.bin", "r")
print(BinaryFile.readUint16(readFile))           -- 65535
print(BinaryFile.readInt16(readFile))            -- -32768
print(BinaryFile.readString(readFile, 5))        -- "Hello"
BinaryFile.close(readFile)
