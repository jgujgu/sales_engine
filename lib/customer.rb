require_relative 'entry'
class Customer < Entry
  def invoices
    @calling_object.find_invoices(@info[:id])
  end

  def transactions
    @calling_object.find_transactions_by_cust_id(@info[:id])
  end

  def favorite_merchant
    @calling_object.find_favorite_merchant(@info[:id])
  end

  def first_name
    @info[:first_name]
  end

  def last_name
    @info[:last_name]
  end
end
