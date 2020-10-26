-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local composer = require( "composer" )

-- Setup theme
local background = display.newImageRect( "kinetic_logo.png", 270, 66 )
background.x = display.contentCenterX
background.y = 60

-- Merchant starts a new transaction
composer.recycleOnSceneChange = true
composer.gotoScene( "new" )
