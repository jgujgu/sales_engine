require_relative 'entry'
class Item < Entry
	 def find_one_by_id(an_id)
    @collection.find {|entry| entry.info[:id] == an_id.to_s}
  end

  def invoice_items
    @calling_object.find_invoice_items(@info[:id])
  end

  def merchant
    @calling_object.find_merchant(@info[:merchant_id])
  end

  def best_day
    @calling_object.find_best_day(@info[:id], @info[:merchant_id])
  end
end
