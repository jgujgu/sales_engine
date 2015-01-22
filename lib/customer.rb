require_relative 'entry'
class Customer < Entry
	def invoices
    @calling_object.find_invoices(@info[:id])		
	end
end
