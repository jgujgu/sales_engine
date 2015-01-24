require_relative "invoice_item"
require_relative "generic_repo"

class InvoiceItemRepository < GenericRepo
  def find_one_by_item_id(it_id)
    @collection.select {|item| item.info[:item_id] == it_id}.sample
  end

  def find_all_by_item_id(it_id)
    @collection.select {|item| item.info[:item_id] == it_id}
  end

  def find_one_by_invoice_id(in_id)
    @collection.select {|item| item.info[:invoice_id] == in_id}.sample
  end

  def find_all_by_invoice_id(in_id)
    @collection.select {|item| item.info[:invoice_id] == in_id}
  end

  def find_invoice(in_id)
    @calling_object.find_invoice_by_invoice_id(in_id)
  end

  def find_item(item_id)
    @calling_object.find_item_by_item_id(item_id)
  end
end
