import "CoreLibs/graphics"
import "CoreLibs/object"

local gfx <const> = playdate.graphics

class("dialog_button").extends()

local hidden = true

local s = gfx.sprite.new()
s:setImage(gfx.image.new("sprites/menu/dialog_button_light"))
s:setZIndex(100)
s:moveTo(200,120)

function dialog_button:init(button_text)
    self.button_text = button_text
end

function dialog_button:draw()
    if hidden then
        s:add()
        hidden = false
    end

    gfx.drawTextInRect(self.button_text, 20, 90, 200, 20)
end

function dialog_button:hide()
    hidden = true
    s:remove()
end