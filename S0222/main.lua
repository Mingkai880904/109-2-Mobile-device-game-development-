-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local tabnum=90
local a = display.newText(tabnum, display.contentCenterX, 20, native.systemFont, 40)
local pic_up = display.newImageRect("up.jpg",80,80)
pic_up.x = display.contentCenterX-80
pic_up.y = 300

local pic_dn = display.newImageRect("down.jpg",80,80)
pic_dn.x = display.contentCenterX+80
pic_dn.y = 300


local function addnum()
  tabnum = tabnum+1
  a.text = tabnum
 pic_up.y = pic_up.y-5
end


pic_up:addEventListener("tap",addnum)

local function addnin()
  tabnum = tabnum-1
  a.text = tabnum
 pic_dn.y = pic_dn.y+5
end


pic_dn:addEventListener("tap",addnin)