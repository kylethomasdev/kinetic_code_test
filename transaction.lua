-----------------------------------------------------------------------------------------
--
-- transaction.lua
--
-----------------------------------------------------------------------------------------
local crypto = require( "crypto" )


function newTransaction (amount)
	local self = {transactionAmount = amount, transactionCard = nil}
    
	local setCard = function (card)
                         self.transactionCard = crypto.hmac( crypto.sha256, card, "thisisasuperlongkey" )
                       end
                       
    local getCard = function () return self.transactionCard end                   
    
    local setAmount = function (amount)
                        self.transactionAmount = amount
                      end
    
    local getAmount = function () return self.transactionAmount end
    
    local processPayment = function ( debug ) 
    						-- fake method to goto online payment
    						return debug 
    						end
    
    return {
        setCard = setCard,
        getCard = getCard,
        setAmount = setAmount,
        getAmount = getAmount,
        processPayment = processPayment
	}
end