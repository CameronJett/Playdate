import "CoreLibs/graphics"
import "CoreLibs/object"

import "dialog_button"

local gfx <const> = playdate.graphics

local buttons = {}
local button_highlight = gfx.sprite.new()
button_highlight:setImage(gfx.image.new("sprites/menu/dialog_button_selector"))
button_highlight:setZIndex(100)
button_highlight:add()
local current_selected_button = 1

local buttons_x_location = 200
local buttons_y_location = 21+33/2
local buttons_y_separation = 22+33
-- 21
-- 33
-- 22
-- 33
-- 22
-- 33
-- 22
-- 33
-- 21

local show_buttons = false -- if buttons are shown, update, allow inputs, draw them

class("dialog_button_manager").extends()

function dialog_button_manager:init()
    local dialog_button1 = dialog_button.new("DIALOG 1")
    dialog_button1:move_to(buttons_x_location, buttons_y_location)
    self:add_button(dialog_button1)

    button_highlight:moveTo(buttons_x_location, buttons_y_location)

    local dialog_button2 = dialog_button.new("DIALOG 2")
    dialog_button2:displayName()
    dialog_button2:move_to(buttons_x_location, (buttons_y_location + buttons_y_separation))
    self:add_button(dialog_button2)

    local dialog_button3 = dialog_button.new("DIALOG 3")
    dialog_button3:displayName()
    dialog_button3:move_to(buttons_x_location, (buttons_y_location + buttons_y_separation * 2))
    self:add_button(dialog_button3)

    local dialog_button4 = dialog_button.new("DIALOG 4")
    dialog_button4:displayName()
    dialog_button4:move_to(buttons_x_location, (buttons_y_location + buttons_y_separation * 3))
    self:add_button(dialog_button4)
end

function playdate.upButtonUp()
	if show_buttons and current_selected_button ~= 1 then
        button_highlight:moveBy(0, -buttons_y_separation)
        current_selected_button -= 1
    end
end

function playdate.downButtonUp()
	if show_buttons and current_selected_button < #buttons then
        button_highlight:moveBy(0, buttons_y_separation)
        current_selected_button += 1
    end
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

-- TODO: show/hide buttons functions
-- TODO: on show set current selected button to first button