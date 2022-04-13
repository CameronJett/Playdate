import "CoreLibs/graphics"
import "CoreLibs/object"

dialog_button = {}
dialog_button.__index = dialog_button

local gfx <const> = playdate.graphics

class("dialog_button").extends()

function dialog_button.new(button_text)
    local instance = setmetatable({}, dialog_button)
    instance.button_text = button_text
    instance.sprite = gfx.sprite.new()
    instance.sprite:setImage(gfx.image.new("sprites/menu/dialog_button_light"))
    instance.sprite:setZIndex(100)
    instance.sprite:moveTo(200,120)
    instance.sprite:add()
    instance.name = "HELLO"
    return instance
end

function dialog_button:move_to(x, y)
    self.sprite:moveTo(x, y)
end

function dialog_button:displayName()
    print(self.name)
end

function dialog_button:draw(show_buttons)
    self.sprite:setVisible(show_buttons)

    if show_buttons then
        gfx.drawTextInRect(self.button_text, self.sprite.x -20, self.sprite.y -10, 200, 20)
    end
end