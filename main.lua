---@diagnostic disable: lowercase-global
io.stdout:setvbuf("no")
local Button = require "button"
local Maths = require "maths"
local Init = require "init"
local Mine = require "mine"
local SafeTile = require "safetile"
local nrows, ncols
local mines, nmines
local tileImages
local tileSet


function love.load()
    love.window.updateMode(1200, 800) -- window size
    love.graphics.setBackgroundColor(0.4, 0.4, 0.4)
    -- love.graphics.setColorMask(true, true, true, true)

    nrows, ncols = 10, 15  -- grid size
    tileImages = Init.tileImages()
    tileSet = {}  -- matrix of tiles (Mines and SafeTiles)
    nmines = 15 -- # of mines
    mines = Init.mines(nmines, nrows, ncols) -- shuffled table(2d) of mines

    -- initalize tileSet with Mines and SafeTiles
    for row = 1, nrows do
        tileSet[row] = {}
        for col = 1, ncols do
            x = 5+(col-1)*tileImages['u']:getWidth()
            y = 5+(row-1)*tileImages['u']:getHeight()
            if mines[row][col] then
                tileSet[row][col] = Mine(tileImages, x, y)
            else
                tileSet[row][col] = SafeTile(tileImages, x, y, Maths.countMinesTouching(mines, row, col))
            end
        end
    end

    ------------- debug
    --  for i = 1, nrows do
    --     for j = 1, ncols do
    --         io.write(tostring(mines[i][j]) .. " ")
    --     end
    --     io.write("\n")
    -- end
    -- io.write("Class: " .. tostring(tileSet[3][3]:is(SafeTile)))
    -------------
end


function love.update(dt)

end


function love.draw()
    -- love.graphics.print("askldjfhaskdf:", 500, 500)
    for row = 1, nrows do
        for col = 1, ncols do
            tileSet[row][col]:draw()
        end
    end

    ------------------ debug
    -- local table = {{3, 3, 3}, {3, 4, 3}}
    -- if table[0] then
    --     love.graphics.print("akjsdf", 500, 500)
    -- end
    -- if pressed then
    --     love.graphics.print(pressed[1] .. pressed[2], 540, 770)
    --     love.graphics.print(tileSet[10][15]:getHover(), 540, 770)
    -- end
    ------------------
end


function love.mousepressed(x, y, button, istouch, presses)
    -- check click is in tile grid
    if x > 5 and x <= ncols*tileImages['u']:getWidth() and y > 5 and y <= nrows*tileImages['u']:getHeight() then
        local tileRow = math.ceil((y - 5)/tileImages['u']:getHeight())
        local tileCol = math.ceil((x - 5)/tileImages['u']:getWidth())
        local tile = tileSet[tileRow][tileCol]
        if button == 1 and not tile.isMarked then -- left click  -- cannot left click marked tile
            -- debug io.write("Is mine?: " .. tostring(tile:is(Mine)) .. "     Is safe?: " .. tostring(tile:is(SafeTile)))
            if tile:is(SafeTile) and not tile.isCleared then
                if tile.minesTouching == 0 then
                    Maths.clearZeroes(tileSet, tileRow, tileCol)
                else
                    tile.isCleared = true
                end
            elseif tile:is(Mine) and not tile.isExploded then
                tile.isExploded = true
            end
        elseif button == 2 then -- right click
            tile.isMarked = not tile.isMarked
        end
    end
end


-- hovering implementation
function love.mousemoved(x, y, dx, dy, istouch)
    -- if x > 5 and x <= ncols*tileImages['u']:getWidth() and y > 5 and y <= nrows*tileImages['u']:getHeight() then
    --     tileSet[math.ceil((y - 5)/tileImages['u']:getHeight())][math.ceil((x - 5)/tileImages['u']:getWidth())]:hover()
    --     pressed = {math.ceil((y - 5)/tileImages['u']:getHeight()), math.ceil((x - 5)/tileImages['u']:getWidth())}
    --     --set button isHovered = true
    -- end

end