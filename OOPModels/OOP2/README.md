# Explanation

This is an attempt to match the Haxe OOP model with Luau constructs.
It is tricky to get unique superclass value fields per subclass instance. It
is easy enough to get access to the superclass methods via mt.__index though.
Refer to `Dog.luau` for more details.

What I think you really want is a metatable object that is an instance
of Animal with all the methods available. That would result in either cloning
all the methods into the instance or at least copying references, or in
having the metatable set to itself. But this does not give access to the
value fields.

More work required.

First, define a set of tests for the desired functionality.