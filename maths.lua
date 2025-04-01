local Object = require "classic"
local Maths = Object:extend()

local SafeTile = require "safetile"
local Mine = require "mine"

function Maths.shuffle(list)
	-- backward iteration from last to second element:
	for i = #list, 2, -1 do
		local j = love.math.random(i) -- between 1 to i (both inclusive)
		list[i], list[j] = list[j], list[i] -- replace both elements by each other
	end
    return list
end

function Maths.countMinesTouching(mines, row, col)
    local nmines = 0
    for i = -1, 1 do
        for j = -1, 1 do
            if mines[row+i] then
                if mines[row+i][col+j] then
                    nmines = nmines + 1
                end
            end
        end
    end
    return nmines
end

-- clears connecting zeroes
function Maths.clearZeroes(tileSet, row, col)
	tileSet[row][col].isCleared = true
	for i = -1, 1 do
		for j = -1, 1 do
			if not (i == 0 and j == 0) and tileSet[row+i] then
				-- io.write("i: " .. i .. ".   j: " .. j .. ".   row: " .. row .. ".   col: " .. col .. "\n")
				local connectedTile = tileSet[row+i][col+j]
				-- io.write("connectedTile: " .. tostring(connectedTile) .. ".   connectedTile:is(SafeTile): " .. tostring(connectedTile:is(SafeTile)) .. ".   connectedTile.countMinesTouching: " .. tostring(connectedTile.countMinesTouching) .. "\n")
				if connectedTile and connectedTile:is(SafeTile) and not connectedTile.isCleared then
					connectedTile.isCleared = true
					if connectedTile.minesTouching == 0 then
						Maths.clearZeroes(tileSet, row+i, col+j)
					end
				end
			end
		end
	end
end

return Maths