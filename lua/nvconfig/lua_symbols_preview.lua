--╭──────────────────────────────────────────────────────────────────────────╮--
--│                  This file is for theme preview purpose.                 │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local my_variable = "Hello, world!" -- Strings
local number = 42 -- numbers
local result = (number + 10) * 2 -- Operators
local my_table = {apple = "fruit", car = "vehicle", dog = "animal"} -- Tables

local function greet(name) -- Functions
    print("Hello, " .. name)
end

-- Control Structures
if number > 0 then
    print(number .. " is positive.")
elseif number == 0 then
    print("Number is 0")
else
    print(number .. " is negative.")
end

for i = 1, 5 do
    print("Iteration " .. i)
end

-- Metatables (for custom behavior)
local mt = {}
mt.__index = function(_, key)
    return "Unknown: " .. key
end
setmetatable(my_table, mt)

-- Print the symbols
print(my_variable)
greet("Lua")
print(result)
print(my_table.apple)
