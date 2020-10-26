local composer = require( "composer" )
local widget = require( "widget" )
 
local scene = composer.newScene()

local infoText
local confirmText
local amountValue
local cardValue

local function handleReset( event )
 
    if ( "ended" == event.phase ) then
        composer.gotoScene( "new" )
        native.setKeyboardFocus( nil )
    end
end 
 
local resetButton = widget.newButton(
    {
        label = "button",
        onEvent = handleReset,
        emboss = false,
        -- Properties for a rounded rectangle button
        shape = "roundedRect",
        width = 200,
        height = 40,
        cornerRadius = 2,
        labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
        fillColor = { default={0.9,0.7,0.1,1}, over={0.9,0.7,0.1,1} }
    }
)
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- Function to handle button events
 
 function processPayment()
 
 	--Fake payment processing here
 	
 	infoText.text = "Payment"
 	confirmText.text = "Sucessful"
 
 	resetButton:setEnabled( true )
	resetButton.alpha = 1
 end
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        amountValue = composer.getVariable( "amountValue" )
       	cardValue = composer.getVariable( "cardValue" )
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        
        -- setup info screen
        infoText = display.newText( "Processing Payment", display.contentCenterX, 130, native.systemFont, 35 )
        confirmText = display.newText( "", display.contentCenterX, 170, native.systemFont, 35 )
        
		resetButton.x = display.contentCenterX
		resetButton.y = 270
 
		-- Change the button's label text
		resetButton:setEnabled( false )
		resetButton.alpha = 0.25
		resetButton:setLabel( "Reset" )
		
		sceneGroup:insert(infoText)
		sceneGroup:insert(confirmText)
		sceneGroup:insert(resetButton)
		
		timer.performWithDelay( 2000, processPayment )
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene