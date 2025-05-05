local BinaryFile = {}

-- Open a binary file for reading or writing
function BinaryFile.open(filename, mode)
    local file, err = io.open(filename, mode .. "b") -- Append "b" for binary mode
    if not file then error("Error opening file: " .. err) end
    return file
end

-- Write an unsigned 16-bit integer (little-endian)
function BinaryFile.writeUint16(file, value)
    file:write(string.char(value & 0xFF, (value >> 8) & 0xFF))
end

-- Write a signed 16-bit integer (little-endian)
function BinaryFile.writeInt16(file, value)
    if value < 0 then value = 65536 + value end
    BinaryFile.writeUint16(file, value)
end

-- Read an unsigned 16-bit integer (little-endian)
function BinaryFile.readUint16(file)
    local bytes = file:read(2)
    local b1, b2 = string.byte(bytes, 1, 2)
    return b1 + b2 * 256
end

-- Read a signed 16-bit integer (little-endian)
function BinaryFile.readInt16(file)
    local value = BinaryFile.readUint16(file)
    if value >= 32768 then value = value - 65536 end
    return value
end

-- Write a string to the file
function BinaryFile.writeString(file, str)
    file:write(str)
end

-- Read a string with a given length
function BinaryFile.readString(file, length)
    return file:read(length)
end

-- Close the binary file
function BinaryFile.close(file)
    file:close()
end

return BinaryFile
