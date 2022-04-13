import "CoreLibs/graphics"
import "CoreLibs/object"

import "main_menu_button"

local gfx <const> = playdate.graphics

local buttons = {}
local button_highlight = gfx.sprite.new()
button_highlight:setImage(gfx.image.new("sprites/menu/main_menu_selector"))
button_highlight:setZIndex(100)
button_highlight:add()

local current_selected_button_x = 1
local current_selected_button_y = 1

local buttons_x_border_spacer = 15
local buttons_x_button_spacer = 20
local buttons_x_size = 175
local buttons_x_location = buttons_x_border_spacer+buttons_x_size/2
local buttons_x_separation = buttons_x_button_spacer+buttons_x_size

local buttons_y_border_spacer = 25
local buttons_y_button_spacer = 20
local buttons_y_size = 85
local buttons_y_location = buttons_y_border_spacer+buttons_y_size/2
local buttons_y_separation = buttons_y_button_spacer+buttons_y_size

-- button spacing
-- 20
-- 85
-- 30
-- 85
-- 20

--  10  175  30  175  10

local show_buttons = true -- if buttons are shown, update, allow inputs, draw them

class("main_menu").extends()

function main_menu:init()
    local move_button = main_menu_button.new("MOVE")
    move_button:move_to(buttons_x_location, buttons_y_location)
    self:add_button(move_button)

    button_highlight:moveTo(buttons_x_location, buttons_y_location)

    local talk_button = main_menu_button.new("TALK")
    talk_button:move_to((buttons_x_location + buttons_x_separation), buttons_y_location)
    self:add_button(talk_button)

    local examine_button = main_menu_button.new("EXAMINE")
    examine_button:move_to(buttons_x_location, (buttons_y_location + buttons_y_separation))
    self:add_button(examine_button)

    local present_button = main_menu_button.new("PRESENT")
    present_button:move_to((buttons_x_location + buttons_x_separation), (buttons_y_location + buttons_y_separation))
    self:add_button(present_button)
end

function playdate.upButtonUp()
	if show_buttons and current_selected_button_y == 2 then
        button_highlight:moveBy(0, -buttons_y_separation)
        current_selected_button_y -= 1
    end
end

function playdate.downButtonUp()
	if show_buttons and current_selected_button_y == 1 then
        button_highlight:moveBy(0, buttons_y_separation)
        current_selected_button_y += 1
    end
end

function playdate.rightButtonUp()
	if show_buttons and current_selected_button_x == 1 then
        button_highlight:moveBy(buttons_x_separation, 0)
        current_selected_button_x += 1
    end
end

function playdate.leftButtonUp()
	if show_buttons and current_selected_button_x == 2 then
        button_highlight:moveBy(-buttons_x_separation, 0)
        current_selected_button_x -= 1
    end
end


function main_menu:add_button(new_button)
    table.insert(buttons, new_button)
    self.update_button_y_location()
end

function main_menu:clear_buttons()
    buttons = {}
end

function main_menu:update_button_y_location()
    -- Use number of buttons to determine starting height
end

function main_menu:get_selected_button()

end

function main_menu:draw()
    button_highlight:setVisible(show_buttons)

    for i, v in ipairs(buttons) do
        v:draw(show_buttons)
    end
end

-- if show_buttons, and a button pressed, go to that flow, hide this flow

-- TODO: show/hide buttons functions
-- TODO: on show set current selected button to first button