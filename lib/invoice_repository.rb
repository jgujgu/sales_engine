require_relative "invoice"
require_relative "generic_repo"
require 'Date'
require 'Time'
require 'byebug'

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

  #def create(invoice_hash = {})
    #invoice = Invoice.new(self)
    #invoice.info[:id] = self.increment_id
    #invoice.info[:customer_id] = invoice_hash[:customer].info[:id]
    #invoice.info[:merchant_id] = invoice_hash[:merchant].info[:id]
    #invoice.info[:status] = invoice_hash[:status]
    #invoice.info[:created_at] = self.current_time
    #invoice.info[:updated_at] = self.current_time
    #@collection << invoice
    #items = invoice_hash[:items]
  #end

  #def create_invoice_items(items)
    #item_ids = items.map {|item| item.info[:id]}
    #ids_with_qty = item_ids.each_with_object(Hash.new(0)) {|item_id, hash| hash[item_id] += 1}
  #end
end
