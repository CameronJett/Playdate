import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "textbox"

-- performance shortcut
local gfx = playdate.graphics

Textbox = { textbox }

function Textbox:new()

	-- now let's put together the textbox sprite

	self.textbox = gfx.sprite.new()
	self.textbox:setSize(220, 180)
	self.textbox:moveTo(200, 120)
	self.textbox:setZIndex(900)
	self.textbox.text = "" -- this is blank for now; we can set it at any point
	self.textbox.currentChar = 1 -- we'll use these for the animation
	self.textbox.currentText = ""
	self.textbox.typing = true

	-- this function will calculate the string to be used. 
	-- it won't actually draw it; the following draw() function will.
	function self.textbox:update()	
		self.currentChar = self.currentChar + 1
		if self.currentChar > #self.text then
			self.currentChar = #self.text
		end
		
		if self.typing and self.currentChar <= #self.text then
			self.currentText = string.sub(self.text, 1, self.currentChar)		
			self:markDirty() -- this tells the sprite that it needs to redraw
		end
		
		-- end typing
		if self.currentChar == #self.text then
			self.currentChar = 1
			self.typing = false		
		end	
	end

	-- this function defines how this sprite is drawn
	function self.textbox:draw()
		-- pushing context means, limit all the drawing config to JUST this block
		-- that way, the colors we set etc. won't be stuck
		gfx.pushContext()
		
			-- draw the box				
			gfx.setColor(gfx.kColorWhite)
			gfx.fillRect(0,0,220,180)
			
			-- border
			gfx.setLineWidth(4)
			gfx.setColor(gfx.kColorBlack)
			gfx.drawRect(0,0,220,180)
			
			-- draw the text!
			gfx.drawTextInRect(self.currentText, 10, 10, 200, 160)
		
		gfx.popContext()
		
	end
	
	function self:update()
		print("UPDATE SELF")
	end

	-- note that we're NOT add()-ing the textbox yet, because we don't want it visible from the start

	-- To see the textbox in action, we'll make the text animate in when A is pressed
	function playdate.AButtonUp()
		self.textbox.text = "Hello from the text sprite!"
		self.textbox:add()
	end
	
	return self

end

