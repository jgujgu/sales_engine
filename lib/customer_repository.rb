require_relative "customer"
require_relative "generic_repo"

class CustomerRepository < GenericRepo
  def find_invoices(cust_id)
    @calling_object.find_invoices_by_cust_id(cust_id)
  end

  def find_transactions_by_cust_id(cust_id)
    @calling_object.find_transactions_by_cust_id(cust_id)
  end
end
