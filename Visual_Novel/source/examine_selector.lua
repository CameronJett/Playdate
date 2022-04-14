import "CoreLibs/graphics"
import "CoreLibs/object"

local gfx <const> = playdate.graphics

local enabled = false

local x_screen_size = 400
local y_screen_size = 240

local default_x = 200
local default_y = 120
local x = x_screen_size / 2
local y = y_screen_size / 2
local box_size = 11
local box_spacer = 5

local move_speed = 2

class("examine_selector").extends()

function examine_selector:init()
    enabled = false
end

function examine_selector:update()
    if enabled then
        if playdate.buttonJustPressed( playdate.kButtonUp ) and y > box_spacer then
            y = y - move_speed
        end
        if playdate.buttonJustPressed( playdate.kButtonDown ) and y < y_screen_size-box_spacer-1 then
            y = y + move_speed
        end
        if playdate.buttonJustPressed( playdate.kButtonRight ) and x < x_screen_size-box_spacer-1 then
            x = x + move_speed
        end
        if playdate.buttonJustPressed( playdate.kButtonLeft ) and x > box_spacer then
            x = x - move_speed
        end 
    end
end

function examine_selector:draw()
    if enabled then
        gfx.drawLine(x, 0, x, y_screen_size)
        gfx.drawLine(0, y, x_screen_size, y)

        gfx.drawRect(x-box_spacer, y-box_spacer, box_size, box_size)
    end
end

-- TODO: show/hide function
-- TODO: on show set x/y to defaults