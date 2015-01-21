require_relative "invoice_item"
require_relative "generic_repo"

class InvoiceItemRepository < GenericRepo
	def find_by_item_id(it_id)
    @collection.select {|item| item.info[:item_id] == it_id}.sample
	end

  def find_all_by_item_id(it_id)
    @collection.select {|item| item.info[:item_id] == it_id}
	end

	def find_by_invoice_id(in_id)
    @collection.select {|item| item.info[:invoice_id] == in_id}.sample
	end

  def find_all_by_invoice_id(in_id)
    @collection.select {|item| item.info[:invoice_id] == in_id}
	end
end