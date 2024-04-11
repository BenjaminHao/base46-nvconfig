-- This file is for demonstrating themes.
-- This is how comments look like.
local my_variable = "Hello, world!"
local number = 42
local result = (number + 10) * 2
local my_table = {apple = "fruit", car = "vehicle", dog = "animal"}

local function greet(name)
    print("Hello, " .. name)
end

if number > 0 then -- if bigger than 0
    print(number .. " is positive.")
elseif number == 0 then -- if equal to 0
    print("Number is 0")
else -- if less than 0
    print(number .. " is negative.")
end

for i = 1, 5 do
    print("Iteration " .. i)
end

local mt = {}
mt.__index = function(_, key)
    return "Unknown: " .. key
end
setmetatable(my_table, mt)

print(my_variable)
greet("Lua")
print(result)
print(my_table.apple)
