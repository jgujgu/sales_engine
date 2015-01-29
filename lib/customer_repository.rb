require_relative "customer"
require_relative "generic_repo"

class CustomerRepository < GenericRepo
  def find_invoices(cust_id)
    @calling_object.find_invoices_by_cust_id(cust_id)
  end

  def find_transactions_by_cust_id(cust_id)
    @calling_object.find_transactions_by_cust_id(cust_id)
  end

  def find_favorite_merchant(cust_id)
    @calling_object.find_favorite_merchant(cust_id)
  end

  def find_by_last_name(query_name)
    @collection.find {|customer| customer.info[:last_name] == query_name}
  end

  def find_all_by_first_name(query_name)
    @collection.select {|customer| customer.info[:first_name] == query_name}
  end
end
