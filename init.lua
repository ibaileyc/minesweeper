local Object = require "classic"
local Init = Object:extend()
local Maths = require "maths"

function Init.mines(nmines, nrows, ncols)
    local tempMines = {} -- temp for single dimensional array
    for i = 1, nmines do
        tempMines[i] = true
    end
    for i = nmines+1, nrows*ncols do
        tempMines[i] = false
    end
    tempMines = Maths.shuffle(tempMines) -- shuffle order

    local mines = {}
    for row = 1, nrows do -- convert to 2d
        mines[row] = {}
        for col = 1, ncols do
            mines[row][col] = tempMines[(row-1)*ncols + col]
        end
    end

    return mines
end

function Init.tileImages() 
    local tileImages = {}  -- array of tile images
    tileImages['u'] = love.graphics.newImage("pics/slick_blue_dotted.png")   -- unknown tile - 'u'
    tileImages['h'] = love.graphics.newImage("pics/slick_light_blue.png")   -- hovered tile - 'h'
    tileImages['p'] = love.graphics.newImage("pics/slick_dark_blue.png")   -- pressed tile - 'p'
    tileImages['c'] = love.graphics.newImage("pics/enhanced_blue.png")   -- cleared tile - 'c'
    tileImages['e'] = love.graphics.newImage("pics/enhanced_red.png")   -- exploded tile - 'e'
    tileImages['m'] = love.graphics.newImage("pics/hexagon_red.png")   -- marked tile - 'm'
    return tileImages
end

return Init