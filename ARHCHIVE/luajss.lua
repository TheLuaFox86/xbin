local StringLib = {}

-- Trim whitespace from both ends of a string
function StringLib.trim(str)
    return str:match("^%s*(.-)%s*$")
end

-- Convert string to uppercase
function StringLib.toUpperCase(str)
    return string.upper(str)
end

-- Convert string to lowercase
function StringLib.toLowerCase(str)
    return string.lower(str)
end

-- Check if a string starts with a given substring
function StringLib.startsWith(str, prefix)
    return str:sub(1, #prefix) == prefix
end

-- Check if a string ends with a given substring
function StringLib.endsWith(str, suffix)
    return str:sub(-#suffix) == suffix
end

-- Get a substring from a string
function StringLib.substring(str, start, finish)
    return str:sub(start, finish)
end

-- Split a string into a table by a delimiter
function StringLib.split(str, delimiter)
    local result = {}
    for match in (str .. delimiter):gmatch("(.-)" .. delimiter) do
        table.insert(result, match)
    end
    return result
end

-- Replace a substring with another string
function StringLib.replace(str, pattern, replacement)
    return str:gsub(pattern, replacement)
end

-- Repeat a string a certain number of times
function StringLib.repeatString(str, count)
    return string.rep(str, count)
end

-- Get the character at a specific position (1-based index)
function StringLib.charAt(str, index)
    return str:sub(index, index)
end

-- Find the index of a substring (1-based index)
function StringLib.indexOf(str, substring)
    local start = str:find(substring, 1, true)
    return start or -1
end

-- Check if a string contains a substring
function StringLib.includes(str, substring)
    return str:find(substring, 1, true) ~= nil
end

return StringLib
