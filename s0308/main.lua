-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local gameloopTimer


local bg = display.newImageRect("bg.jpg",360,570)
bg.x = display.contentCenterX
bg.y = display.contentCenterY

local score = 100
local show_score = display.newText(score,50,20,native.systemFont,40)

local bar = display.newImageRect("station.jpg",100,80)
bar.x = display.contentCenterX
bar.y = display.contentCenterY+200

local ship = display.newImageRect("ship.png",80,150)
ship.x = display.contentCenterX
ship.y = 10

local physics = require("physics")
physics.start()

physics.addBody(bar,"static")
physics.addBody(ship,"dynamic",{rasius=50,bounce=0.5})

local function ship_R()
  ship:applyLinearImpulse(0.1,0,ship.x , ship.y)
  
end
ship:addEventListener("tap",ship_R)

local function onCollision(event)
score = score - 2
show_score.text = score
display.remove(event.object2)
 if score<1 then
  display.remove(event.object1)
  physics.removeBody(event.object1)
 end
end
Runtime:addEventListener("collision",onCollision)


local function gameLoop()
  
  local ship1 = display.newImageRect("ship.png",80,150)
  ship1.x = display.contentCenterX-math.random(-150,150)
  ship1.y = 10
  physics.addBody(ship1,"dynamic",{radius=50,bounce=0.3})
end
gameLoopTimer = timer.performWithDelay(1000,gameLoop,0)