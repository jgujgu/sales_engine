require_relative 'entry'
class Item < Entry
	def merchant
    @calling_object.find_merchant(@info[:merchant_id])  
	end
end
