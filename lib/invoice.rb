require_relative 'entry'
class Invoice < Entry
  def transactions
    @calling_object.find_transactions(@info[:id])
  end

  def invoice_items
    @calling_object.find_invoice_items(@info[:id])
  end

  def customer
    @calling_object.find_customer(@info[:customer_id])
  end

  def merchant
    @calling_object.find_merchant(@info[:merchant_id])
  end

  def items
    @calling_object.find_items(@info[:id])
  end

  def customer_id
    @info[:customer_id].to_i
  end
end
