require_relative 'entry'
class Item < Entry
  def invoice_items
    @calling_object.find_invoice_items(@info[:id])
  end

  def merchant
    @calling_object.find_merchant(@info[:merchant_id])
  end
end
