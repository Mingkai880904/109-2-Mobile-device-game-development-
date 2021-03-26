-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local bg = display .newImageRect("bg.jpg",360,570)
bg.x = display.contentCenterX
bg.y = display.contentCenterY

local ball = display .newImageRect("ball.png",80,150)
ball.x = display.contentCenterX
ball.y = 10

local bar = display .newImageRect("bar.jpg",300,50)
bar.x = display.contentCenterX
bar.y = display.contentHeight-25

local physics = require("physics")
physics.start()

physics.addBody(bar,"static")
physics.addBody(ball,"dynamic",{rasius=50,bounce=0.3})

local function pushball()
  ball:applyLinearImpulse(0,-0.75,ball.x , ball.y)
  
end
ball:addEventListener("tap",pushball)