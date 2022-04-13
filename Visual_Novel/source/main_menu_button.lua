import "CoreLibs/graphics"
import "CoreLibs/object"

main_menu_button = {}
main_menu_button.__index = main_menu_button

local gfx <const> = playdate.graphics

class("main_menu_button").extends()

function main_menu_button.new(button_text)
    local instance = setmetatable({}, main_menu_button)
    instance.button_text = button_text
    instance.sprite = gfx.sprite.new()
    instance.sprite:setImage(gfx.image.new("sprites/menu/main_menu_button"))
    instance.sprite:setZIndex(100)
    instance.sprite:moveTo(200,120)
    instance.sprite:add()
    return instance
end

function main_menu_button:move_to(x, y)
    self.sprite:moveTo(x, y)
end

function main_menu_button:draw(show_button)
    self.sprite:setVisible(show_button)

    if show_button then
        gfx.drawTextInRect(self.button_text, self.sprite.x -20, self.sprite.y -10, 200, 20)
    end
end