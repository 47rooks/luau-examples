local Animal = require("./Animal")

local Dog = require("./Dog")

local animal = Animal.new("Generic")

local dog = Dog.new("Buddy")

print('animal via its __tostring ' .. tostring(animal))

print('dog via parent __tostring ' .. tostring(dog))

print('dog name via getAnimalName ' .. dog:getAnimalName())
print('dog.name', dog.name)
print(Dog.getName(dog))
print('rawget of dog name ' .. tostring(rawget(dog, "name")))
print('tostring of table' .. tostring({}))

local mytable = {}
setmetatable(mytable, Dog)
print(getmetatable(mytable))

print('--- Metatable and __index tests ---')
-- Simple metatable and __index tests
a = {foo = 1}
b = {bar = 2}
c = {bar = 3}
setmetatable(a, b)
print('a.foo =', a.foo)
print('a.bar =', a.bar)
b.__index = b
-- setmetatable(a, {__index = c})
print('a.foo =', a.foo)
print('a.bar =', a.bar)
print('a.mt =', getmetatable(a))

print('--- Test __index behaviour with and without metatable set ---')
-- Set __index of a table to itself or anything - what does that do ?
aa = {}
-- Uncommment to test behavior of __index
aa.__index = function (t, k)
    print("Looking for key", k)
    return 99
end
aa.foo = 42
print('aa.foo =', aa.foo)
print('aa.baa =', aa.baa)
setmetatable(aa, aa)
print('aa.foo =', aa.foo)
print('aa.baa =', aa.baa)

-- Check infinite loop of __index in mt.__index = mt case
print('--- Check infinite loop of __index in mt.__index = mt case ---')
bb = {}
bb.__index = bb
bla = setmetatable({}, bb)
print('bla.__index =', bla.__index)
print('bla.__index.__index =', bla.__index.__index)
print('bla.mt =', getmetatable(bla))
print('bla.mt.__index =', getmetatable(bla).__index)
-- The below blows up because bla.__index has no metatable set
-- local bla_mt = getmetatable(bla)
-- print('bla_mt.mt.__index =', getmetatable(bla_mt).__index)

-- Parent child grandhild metatable chain test
-- This shows that the __index method of the mt is what is used to resolve
-- missing keys. If __index is set on the table itself then it is ignored. If
-- there is no __index method on the mt, then nothing is found.
print('--- Parent child grandhild metatable chain test ---')

p = {}
p.__index = p
c = setmetatable({}, p)
c.__index = c
gc = setmetatable({}, c)

p.foo = "parent_foo"
-- c.foo = "child_foo"
-- gc.foo = "grandchild_foo"

print('gc.foo =', gc.foo)
print('gc.bar =', gc.bar)


print('--- Test superclass field access from subclass instance ---')

a = {name='Animal',
     __tostring = function(self)
         print("Animal __tostring called")
         return self.name
     end}
a.__index = a
b = setmetatable({}, a)
print('b.name =', b.name)
print('tostring(b) =', tostring(b))
