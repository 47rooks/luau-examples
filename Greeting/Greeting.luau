-- Greeting module
local Greeting = {}

export type GreetingType = {
	greet: (name: string) -> ()
}

function Greeting.create(message: string): GreetingType
	return {
		greet = function(name: string)
			print(message .. " " .. name)
		end
	}
end

return Greeting