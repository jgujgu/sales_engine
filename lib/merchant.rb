require_relative 'entry'
class Merchant < Entry
	def items
		@calling_object.find_items(@info[:id])
	end

	def invoices
		@calling_object.find_invoices(@info[:id])
	end

	def favorite_customer
    @calling_object.find_favorite_customer(@info[:id])		
	end

  def customers_with_pending_invoices
    @calling_object.find_customers_with_pending_invoices(@info[:id])
  end
  
  def revenue(date = nil)
    if date then @calling_object.find_revenue_by_date_per_merchant(date, @info[:id])
    else @calling_object.find_revenue_per_merchant(@info[:id])
    end
  end
end
