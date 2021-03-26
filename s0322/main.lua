-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local hou_life=20 --房子可承受打擊
local asteroidsTable={}
local physics = require("physics")
physics.start()

local bg = display.newImageRect("bg1.jpg",360,570)
bg.x = display.contentCenterX
bg.y = display.contentCenterY

local show_bomb = display.newText(0,50,20,native.systemFont,40)
local show_hou = display.newText(hou_life,250,20,native.systemFont,40)

local hou = display.newImageRect("house.png",150,50)
hou.myhouse ="House"
physics.addBody(hou,"static")
hou.x = display.contentCenterX
hou.y = display.contentCenterY+200

--發射台
local fort = display.newImageRect("a03.png",50,60)
fort.x=display.contentCenterX
fort.y=display.contentHeight-80

--移動發射台
local function dragfort(event)
  local fort = event.target
  local phase = event.phase
  if("began" == phase)then
    display.currentStage:setFocus(fort)
    fort.touchOffsetX = event.x - fort.x
elseif("moved" == phase)then
  fort.x=event.x-fort.touchOffsetX
elseif("ended" == phase or "cancelled" == phase)then
  display.currentStage:setFocus(nil)
  end
  return true
end
fort:addEventListener("touch",dragfort)

local function fire_missle()
  local newMis = display.newImageRect("a03.png",50,60)
  physics.addBody(newMis,"dynamic",{isSensor=true})
  newMis.isBullet=true
  newMis.myName="Missle"
  
  newMis.x=fort.x
  newMis.y=fort.y
  --newMis:toBack()
  
  transition.to(newMis,{y=-40,time=500,
      onComplete = function() display.remove(newMis) end
      })
  end
  fort:addEventListener("tap",fire_missle)


--當碰撞發生
local function onCollision(event)
  if(event.phase == "began")then
    local obj1 = event.object1
    local obj2 = event.object2
    if((obj1.myName == "Missle" and obj2.myname == "asteroid")or
      (obj1.myName == "asteroid" and obj2.myname == "Missle"))
    then
      display.remove(obj1)
      display.remove(obj2)
    for i =#asteroidsTable,1,-1 do --從炸彈的table移除炸彈
      if(asteroidsTable[i]==obj1 or asteroidsTable[i] == obj2)then
        table.remove(asteroidsTable,i)
        break
    end
   end
 end
 --炸彈&房子
 local isHit = 0
 local obj3
 if  (obj1.myName =="asteroid" and obj2.myName == "House") then
  display.remove(obj1) --從畫面移除炸彈
   isHit=1
   obj3=obj1
  end
   if  (obj1.myName =="House" and obj2.myName == "asteroid")then
  display.remove(obj2) --從畫面移除炸彈
  isHit=1
   obj3=obj2
 end  
 if(isHit==1)then
    hou_life =hou_life - 1
   show_hou.text=hou_life  
 
 for i =#asteroidsTable,1,-1 do --從炸彈的table移除炸彈
    if(asteroidsTable[i]==obj3)then
    table.remove(asteroidsTable,i)
    break
    end
   end
  end
end
  local obj1 = event.object1
  local obj2 = event.object2
end
Runtime:addEventListener("collision",onCollision)

local function creatAsteroid()
  show_bomb.text=#asteroidsTable
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
   --檢查炸彈是否超出螢幕範圍
   for i = #asteroidsTable,1,-1 do
     local thisAsteroid = asteroidsTable[i]
     if(thisAsteroid.x < -100 or
       thisAsteroid.x > display.contentWidth + 100 or
       thisAsteroid.y < -100 or
       thisAsteroid.y > display.contentHeight + 100)
   then  
     display.remove(thisAsteroid)
     table.remove(asteroidsTable,i)
   end
 end
end
 gameLoopTimer = timer.performWithDelay(1000,gameLoop,0)