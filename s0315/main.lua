-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local asteroidsTable={}
local physics = require("physics")
physics.start()

local bg = display.newImageRect("bg1.jpg",360,570)
bg.x = display.contentCenterX
bg.y = display.contentCenterY

local hou = display.newImageRect("house.png",150,50)
hou.x = display.contentCenterX
hou.y = display.contentCenterY+200

local function creatAsteroid()
  local newAsteroid = display.newImageRect("a00.png",40,40)
  table.insert(asteroidsTable,newAsteroid)
  physics.addBody(newAsteroid,"dynamic",{radius=40,bounce=0.8})
  newAsteroid.myname = "asteroid"
  
  newAsteroid.x = math.random(0,300)
  newAsteroid.y = 10
  newAsteroid:setLinearVelocity(math.random(40,120),math.random(20,60))
  newAsteroid:applyTorque(math.random(-6,6))
 end 
local function gameLoop()
   creatAsteroid()
end
 gameLoopTimer = timer.performWithDelay(1000,gameLoop,0)