type function f(t: type)
  local p1 = t:readproperty(types.singleton("p"))
  local p2 = t:readproperty(types.singleton("p"))
  assert(p1 and p2)

  local m = {}
  m[p1] = types.singleton("p1")
  m[p2] = types.singleton("p2")
  return m[p1]
end

type t = { p: t }

type result = f<t>
