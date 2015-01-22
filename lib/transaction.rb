require_relative 'entry'
class Transaction < Entry
	def invoice
    @calling_object.find_invoice(@info[:invoice_id])
	end
end
