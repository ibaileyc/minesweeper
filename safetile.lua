local Button = require "button"
local SafeTile = Button:extend()

function SafeTile:new(imageSet, x, y, minesTouching)
    SafeTile.super.new(self, imageSet, x, y)
    self.minesTouching = minesTouching
    self.isCleared = false
end

local function drawCenteredText(rectX, rectY, rectWidth, rectHeight, text)
	local font = love.graphics.getFont()
	local textWidth = font:getWidth(text)
	local textHeight = font:getHeight()
    love.graphics.print(text, rectX+rectWidth/2, rectY+rectHeight/2, 0, 1, 1, textWidth/2, textHeight/2)
end

function SafeTile:draw()
    local image = nil
    if self.isCleared then
        image = self.imageSet['c']
        love.graphics.draw(image, self.x, self.y)
        -- local blend = love.graphics.getBlendMode()
        -- love.graphics.setBlendMode("replace")
        drawCenteredText(self.x, self.y, image:getWidth(), image:getHeight(), tostring(self.minesTouching))
        return
    elseif self.isMarked then
        image = self.imageSet['m']
    elseif self.isPressed then
        image = self.imageSet['p']
    elseif self.isHovered then 
        image = self.imageSet['h']
    else
        image = self.imageSet['u']
    end
    love.graphics.draw(image, self.x, self.y)
end


function SafeTile:updateMinesTouching(tileSet, row, col)
    local nmines = 0
    for i = -1, 1 do
        for j = -1, 1 do
            if tileSet[row][col] then
                nmines = nmines + 1
            end
        end
    end
    return nmines
end

function SafeTile.countMinesTouching(mines, row, col)
    local nmines = 0
    print(mines)
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

return SafeTile