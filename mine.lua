local Button = require "button"
local Mine = Button:extend()

function Mine:new(imageSet, x, y)
    Mine.super.new(self, imageSet, x, y)
    self.isExploded = false
end

function Mine:draw()
    local image = nil
    if self.isExploded then
        image = self.imageSet['e']
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

return Mine