local Utils = {}

local visited = {}

function Utils.dumpTable(name, tab, indent)

    local function _dumpTable(t, indent)
        if (visited[t]) then
            -- cycle detected, return to avoid infinite recursion
            print(string.rep(" ", indent + 2) .. "SELF-REFERENCE (cycle detected)")
            return
        end
        visited[t] = true
        for k, v in pairs(t) do
            if (type(v) == "table") then
                print(string.rep(" ", indent + 2) .. k .. " = {")
                _dumpTable(v, indent + 4)
                print(string.rep(" ", indent + 2) .. "}")
            else
                if (type(v) == "function") then
                    print(string.rep(" ", indent + 2) .. k .. " = function")
                else
                    -- if (not v) then
                    --     print(string.rep(" ", indent + 2) .. k .. " = nil")
                    -- else
                        print(string.rep(" ", indent + 2) .. k .. " = " .. tostring(v))
                    -- end
                end
            end
        end
        visited[t] = false
    end

    print(string.rep(" ", indent) .. "Dumping table: " .. name)

    _dumpTable(tab, indent)

    print("End of table: " .. name)
end

return Utils