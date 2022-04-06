import "CoreLibs/graphics"
import "CoreLibs/object"

import "dialog_button"

local gfx <const> = playdate.graphics

local buttons = {}
local button_highlight = gfx.sprite.new()
button_highlight:setImage(gfx.image.new("sprites/menu/dialog_button_selector"))
button_highlight:setZIndex(100)
button_highlight:moveTo(200,120)
button_highlight:add()

local buttons_x_location = 200
local buttons_y_location = 0
local buttons_y_separation = 50

local show_buttons = true -- if buttons are shown, update, allow inputs, draw them

class("dialog_button_manager").extends()

function dialog_button_manager:init()
    local dialog_button1 = dialog_button.new("DIALOG 1")
    self:add_button(dialog_button1)
    local dialog_button2 = dialog_button.new("DIALOG 2")
    dialog_button2:displayName()
    dialog_button2:move_to(200, 170)
    self:add_button(dialog_button2)
end

function dialog_button_manager:add_button(new_button)
    table.insert(buttons, new_button)
    self.update_button_y_location()
end

function dialog_button_manager:generate_button_list_by_id(id)
    -- use current act and id to find and generate button list from dialog file
end

function dialog_button_manager:clear_buttons()
    buttons = {}
end

function dialog_button_manager:update_button_y_location()
    -- Use number of buttons to determine starting height
end

function dialog_button_manager:has_dialog_buttons()
    -- If no dialog buttons we can disable talk button in menu
    return #buttons > 0
end

function dialog_button_manager:get_selected_button()

end

function dialog_button_manager:draw()
    button_highlight:setVisible(show_buttons)

    for i, v in ipairs(buttons) do
        v:draw(show_buttons)
    end
end

-- if show_buttons, and a button pressed, start dialog for selected button