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

  #def create_invoice_items(items, invoice_id)
    #item_ids = items.map {|item| item.info[:id]}
    #ids_with_qty = item_ids.each_with_object(Hash.new(0)) {|item_id, hash| hash[item_id] += 1}
    #ids_with_qty.each do |item_id, qty|
      #item = Item.new(self)
      #item.info = {item_id: item_id, invoice_id: invoice_id, quantity: qty.to_s, }
      #@collection << Item.new(self).info =
    #end
  #end
end
