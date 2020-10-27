-----------------------------------------------------------------------------------------
--
-- transaction.lua
--
-----------------------------------------------------------------------------------------
--local crypto = require( "crypto" )


function newTransaction ()
	local self = {transactionAmount = nil, transactionCard = nil}
    
	local setCard = function (card)
						if (string.len(card) == 8 and string.len(card) < 9) then
                    		--self.transactionCard = crypto.hmac( crypto.sha256, card, "thisisasuperlongkey" )
                    		self.transactionCard = card
                    	else
                    		error("Card must be 8 characters long")
                    	end
                    end
                       
    local getCard = function () return self.transactionCard end                   
    
    local setAmount = function (amount)
    					if (tonumber(amount) > 0  ) then
                        	self.transactionAmount = tonumber(amount)
                        else
                        	error("Amount must be grater than 0")
                        end
                      end
    
    local getAmount = function () return self.transactionAmount end
    
    local processPayment = function ( debug )
    							
    							if( self.transactionAmount == nil and self.transactionCard == nil) then
    								error("Card and Amount must be set")
    							else
    								-- fake method to goto online payment
    								return debug
    							end
    						end
    
    return {
        setCard = setCard,
        getCard = getCard,
        setAmount = setAmount,
        getAmount = getAmount,
        processPayment = processPayment
	}
end