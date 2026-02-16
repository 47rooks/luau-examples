-- New file
-- Dog subclass module
local Animal = require("./Animal")

-- Creating an Animal instance as the metatable base for Dog is required to
-- to access the :_tostring() method from Animal because we need an object
-- instance. Without this you need to use a new metatable with __index pointing
-- to Animal. That said this really isn't properly setup example yet.
-- local Dog = setmetatable({}, {__index = Animal}) -- introduces a third table
local Dog = setmetatable({}, Animal) -- only 2 tables - Dog and mt of Animal with __index = to Animal
-- local Dog = {}
-- local Dog = setmetatable({}, Animal.new("DogBase"))
--Dog.__index = Dog

function Dog.new(name: string)
    print('Dog.new entering')

    -- Works but introduces a third table in between Dog and Animal
	-- local self = setmetatable(Dog, {__index = Animal.new(name),
	-- 								__tostring = Animal.__tostring
	-- })

    -- Only uses two tables but fails because Dog cannot access Animal:name
    -- because it's not part of Animal, but only part of the metatable object.
	-- As a result it's not accessible via mt.__index.
    local self = setmetatable(Dog, Animal.new(name))
	
	-- local self = setmetatable({}, Animal.new(name))
	-- local self = setmetatable({}, Dog)
	-- self.name = name
    print(getmetatable(self))
    print('Dog.new leaving')
	return self
end

function Dog:__tostring()
	return "Dog " .. self.name
end

function Dog.getName(self)
	return "Dog " .. self.name
end

return Dog