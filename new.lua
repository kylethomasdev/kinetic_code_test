local composer = require( "composer" )
local widget = require( "widget" )
 
local scene = composer.newScene()

local infoText
local amountText
local amountField
local transaction 

local function handleCheckout( event )
 
    if ( "ended" == event.phase ) then
    	transaction = newTransaction(amountField.text)
    	composer.setVariable( "transaction",  transaction)
        composer.gotoScene( "customer" )
        native.setKeyboardFocus( nil )
    end
end 
 
local checkoutButton = widget.newButton(
    {
        label = "button",
        onEvent = handleCheckout,
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
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- Function to handle button events

local function toggleButton ( button )
	if ( button.isEnabled ) then
		button:setEnabled( false )
		button.alpha = 0.25 
	else
		button:setEnabled( true )
		button.alpha = 1 	
	end

end
 
local function onEnterAmount( event )
    -- Hide keyboard when the user clicks "Return" in this field
    if ( "submitted" == event.phase ) then
        native.setKeyboardFocus( amountField )
    
    elseif ( "editing" == event.phase) then
    
    	-- check we dont have an empty field
		if (amountField.text == "" ) then
			amountField.text = 0
			toggleButton( checkoutButton )
		else
			toggleButton( checkoutButton )		
		end
		
		-- output a nicely formatted version of the amount
		amountText.text = string.format("£%.2f", amountField.text )
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
        composer.setVariable( "amountValue", 0 )
        composer.setVariable( "cardValue", 0 )
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        
        -- setup info screen
        infoText = display.newText( "Enter Amount GBP", display.contentCenterX, 130, native.systemFont, 35 )
        
        -- setup amount 
        amountText = display.newText( "£00.00", display.contentCenterX, 170, native.systemFont, 35 )
        amountField = native.newTextField( display.contentCenterX, 220, 320, 35 )
		amountField.inputType = "decimal"
		amountField.align = "center"
		amountField:addEventListener( "userInput", onEnterAmount )
		
		-- focus on the field automatically
		native.setKeyboardFocus( amountField )
		
		--setup buttons
		checkoutButton.x = display.contentCenterX
		checkoutButton.y = 270
 
		-- Change the button's label text
		checkoutButton:setLabel( "Checkout" )
		checkoutButton:setEnabled( false )
		checkoutButton.alpha = 0.25
		
		sceneGroup:insert(infoText)
		sceneGroup:insert(amountText)
		sceneGroup:insert(amountField)
		sceneGroup:insert(checkoutButton)
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