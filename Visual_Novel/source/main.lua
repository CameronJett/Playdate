import "dialog_button_manager"
import "examine_selector"

local dialog_button_manager = dialog_button_manager()
local examine_selector = examine_selector()

local gfx <const> = playdate.graphics
local font = gfx.font.new('font/Mini Sans 2X') -- DEMO

local function loadGame()
	playdate.display.setRefreshRate(50) -- Sets framerate to 50 fps
	gfx.setFont(font) -- DEMO
end

local function updateGame()
	examine_selector:update()
end

local function drawGame()
	gfx.clear() -- Clears the screen

	gfx.sprite.update()

	dialog_button_manager:draw()
	examine_selector:draw()
end

loadGame()

function playdate.update()
	updateGame()
	drawGame()
	playdate.drawFPS(0,0) -- FPS widget
end

-- 400 x 240
-- 21
-- 33
-- 22
-- 33
-- 22
-- 33
-- 22
-- 33
-- 21