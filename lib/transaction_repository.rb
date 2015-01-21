require_relative "transaction"
require_relative "generic_repo"

class TransactionRepository < GenericRepo
	def find_by_invoice_id(in_id)
    @collection.select {|item| item.info[:invoice_id] == in_id}.sample
	end

  def find_all_by_invoice_id(in_id)
    @collection.select {|item| item.info[:invoice_id] == in_id}
	end
end