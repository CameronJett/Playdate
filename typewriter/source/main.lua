import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "textbox"

-- performance shortcut
local gfx = playdate.graphics

-- let's set up a "game sprite" to put in the background
local s = gfx.sprite.new()
s:setImage(gfx.image.new("leaf"))
s:setZIndex(100)
s:moveTo(100,100)
s:add()

local textbox = Textbox:new()

function playdate.update()
	gfx.sprite.update()
	--textbox:update()
end