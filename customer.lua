local composer = require( "composer" )
local widget = require( "widget" )
 
local scene = composer.newScene()

local infoText
local cardField
local amountValue

local function handlePay( event )
 
    if ( "ended" == event.phase ) then
        composer.gotoScene( "process" )
        composer.setVariable( "cardValue", cardField.text )
        native.setKeyboardFocus( nil )
    end
end 

local function handleReset( event )
 
    if ( "ended" == event.phase ) then
        composer.gotoScene( "new" )
        native.setKeyboardFocus( nil )
    end
end 
 
local payButton = widget.newButton(
    {
        label = "button",
        onEvent = handlePay,
        emboss = false,
        -- Properties for a rounded rectangle button
        shape = "roundedRect",
        width = 200,
        height = 40,
        cornerRadius = 2,
        labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
        fillColor = { default={0,0.7,0,1}, over={0,0.7,0,1} }
    }
)

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
 
local function onEnterCard( event )
    -- Hide keyboard when the user clicks "Return" in this field
    if ( "submitted" == event.phase ) then
        native.setKeyboardFocus( cardField )
    
    elseif ( "editing" == event.phase) then
    
    	-- check we dont have an empty field
		if (string.len(cardField.text) == 8 ) then
			payButton:setEnabled( true )
			payButton.alpha = 1 
		else
			payButton:setEnabled( false )
			payButton.alpha = 0.25 		
		end
		
    end
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
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        
        -- setup info screen
        infoText = display.newText( "Enter Card Number", display.contentCenterX, 130, native.systemFont, 35 )
        amountText = display.newText( string.format("£%.2f", amountValue ), display.contentCenterX, 170, native.systemFont, 35 )
        
        -- setup amount 
        cardField = native.newTextField( display.contentCenterX, 220, 320, 35 )
		cardField.inputType = "number"
		cardField.align = "center"
		cardField:addEventListener( "userInput", onEnterCard )
		
		-- focus on the field automatically
		native.setKeyboardFocus( cardField )
		
		--setup buttons
		payButton.x = display.contentCenterX
		payButton.y = 270
		resetButton.x = display.contentCenterX
		resetButton.y = 320
 
		-- Change the button's label text
		payButton:setLabel( "Pay" )
		payButton:setEnabled( false )
		payButton.alpha = 0.25
		
		resetButton:setLabel( "Reset" )
		
		sceneGroup:insert(infoText)
		sceneGroup:insert(amountText)
		sceneGroup:insert(cardField)
		sceneGroup:insert(payButton)
		sceneGroup:insert(resetButton)
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