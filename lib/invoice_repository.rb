require_relative "invoice"
require_relative "generic_repo"

class InvoiceRepository  < GenericRepo
	def find_one_by_customer_id(cust_id)
    @collection.select {|item| item.info[:customer_id] == cust_id}.sample
	end

  def find_all_by_customer_id(cust_id)
    @collection.select {|item| item.info[:customer_id] == cust_id}
	end

	def find_one_by_merchant_id(merch_id)
    @collection.select {|item| item.info[:merchant_id] == merch_id}.sample
	end

  def find_all_by_merchant_id(merch_id)
    @collection.select {|item| item.info[:merchant_id] == merch_id}
	end

	def find_transactions(in_id)
		@calling_object.find_transaction_by_invoice_id(in_id)
	end

	def find_invoice_items(in_id)
		@calling_object.find_invoice_items_by_invoice_id(in_id)
	end

	def find_customer(cust_id)
		@calling_object.find_customer_by_cust_id(cust_id)
	end

	def find_merchant(merch_id)
		@calling_object.find_merchant_by_merch_id(merch_id)
	end

	def find_items(in_id)
		@calling_object.find_items_by_invoice_id(in_id)
	end
end