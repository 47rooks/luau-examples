type function f(a, b)
  local t = {}
  t[a] = types.singleton(true)
  t[b] = types.singleton(false)
  return t[a]
end

type result = f<number, number>

local a:result = true

print(typeof(a))
