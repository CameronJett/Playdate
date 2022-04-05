import "dialog_button"
import "dialog_button_manager"
local dialog_button = dialog_button("DIALOG 1")
local dialog_button_manager = dialog_button_manager()

local gfx <const> = playdate.graphics
local font = gfx.font.new('font/Mini Sans 2X') -- DEMO

local function loadGame()
	playdate.display.setRefreshRate(50) -- Sets framerate to 50 fps
	gfx.setFont(font) -- DEMO
	dialog_button_manager:add_button(dialog_button)
end

local function updateGame()
	
end

local function drawGame()
	gfx.clear() -- Clears the screen
	
	dialog_button_manager:draw()

	gfx.sprite.update()
end

loadGame()

function playdate.update()
	updateGame()
	drawGame()
	playdate.drawFPS(0,0) -- FPS widget
end