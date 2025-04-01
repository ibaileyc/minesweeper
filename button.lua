local Object = require "classic"
local Button = Object:extend()

function Button:new(imageSet, x, y)
    self.imageSet = imageSet
    self.x = x
    self.y = y
    self.isHovered = false
    self.isPressed = false
    self.isMarked = false
end

function Button:getWidth()
    self.imageSet.getWidth()
end

function Button:getHeight()
    self.imageSet.getHeight()
end

return Button