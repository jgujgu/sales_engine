require_relative "item"
require_relative "generic_repo"

class ItemRepository < GenericRepo
  def find_one_by_merchant_id(merch_id)
    @collection.select {|item| item.info[:merchant_id] == merch_id}.sample.info
  end

  def find_all_by_merchant_id(merch_id)
    @collection.select {|item| item.info[:merchant_id] == merch_id}.map {|item| item.info}
  end

  def find_invoice_items(item_id)
    @calling_object.find_invoice_items_by_item_id(item_id)
  end

  def find_merchant(merch_id)
    @calling_object.find_merchant_by_merch_id(merch_id)
  end

  def most_revenue(num_of_items)
    items_in_order = @collection.sort_by do |item|
      -@calling_object.find_revenue_by_item(item.info[:id], item.info[:merchant_id])
    end
    items_in_order[0..(num_of_items - 1)]
  end

  def most_items(num_of_items)
    items_in_order = @collection.sort_by do |item|
      -@calling_object.find_qty_by_item(item.info[:id], item.info[:merchant_id])
    end
    items_in_order[0..(num_of_items - 1)]
  end

  def find_best_day(item_id, merch_id)
    @calling_object.find_best_day(item_id, merch_id)
  end
end
