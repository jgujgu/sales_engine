require_relative "invoice"
require_relative "generic_repo"

class InvoiceRepository  < GenericRepo
	def find_by_customer_id(cust_id)
    @collection.select {|item| item.info[:customer_id] == cust_id}.sample
	end

  def find_all_by_customer_id(cust_id)
    @collection.select {|item| item.info[:customer_id] == cust_id}
	end

	def find_by_merchant_id(merch_id)
    @collection.select {|item| item.info[:merchant_id] == merch_id}.sample
	end

  def find_all_by_merchant_id(merch_id)
    @collection.select {|item| item.info[:merchant_id] == merch_id}
	end
end