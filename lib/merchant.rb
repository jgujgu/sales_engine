require_relative 'entry'
class Merchant < Entry
	def items
		@calling_object.find_items(@info[:id])
	end

	def invoices
		@calling_object.find_invoices(@info[:id])
	end
end
