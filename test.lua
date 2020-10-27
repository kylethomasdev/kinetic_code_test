-----------------------------------------------------------------------------------------
--
-- test.lua
--
-----------------------------------------------------------------------------------------
require 'busted.runner'()
require( "transaction")

describe("A transation", function()
	local transaction 
	
	before_each(function()
      transaction = newTransaction()
    end)
	
    it("should start with nil values", function()
      assert.are_equal(transaction.getAmount(), nil)
      assert.are_equal(transaction.getCard(), nil)
    end)
    
    it("should only allow amounts over 0", function()
      transaction.setAmount(12.00)
      assert.are_equal(transaction.getAmount(), 12.00)
      assert.has.errors(function() transaction.setAmount(00.00) end)
    end)
    
    it("should only allow cards grater than 8 characters but less than 9", function()
      transaction.setCard(12345678)
      assert.are_equal(transaction.getCard(), 12345678)
      assert.has.errors(function() transaction.setCard(123456789) end)
    end)
    
    it("should only allow a transaction when amount and card are set", function()
      assert.has.errors(function() transaction.processPayment(true) end)
      transaction.setCard(12345678)
      transaction.setAmount(12.00)
      assert.is_true(transaction.processPayment(true))
    end)
    
    it("should not process a payment if debug is false", function()
      transaction.setCard(12345678)
      transaction.setAmount(12.00)
      assert.is_false(transaction.processPayment(false))
    end)
end)