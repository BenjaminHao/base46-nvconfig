-- This file is for theme preview purpose.
--[[
   Multi-line comment
   Line 2
]]
-- Variables
local my_variable = "Hello, world!"
local number = 42
-- Functions
local function greet(name)
    print("Hello, " .. name)
end
-- Control Structures
if number > 30 then
    print("Number is greater than 30")
elseif number == 30 then
    print("Number is exactly 30")
else
    print("Number is less than 30")
end
for i = 1, 5 do
    print("Iteration " .. i)
end
-- Operators
local result = (number + 10) * 2
-- Tables
local my_table = {apple = "fruit", car = "vehicle", dog = "animal"}
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
