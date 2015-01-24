require_relative "merchant"
require_relative "generic_repo"

class MerchantRepository < GenericRepo
  def find_one_by_name(merch_name)
    @collection.find {|merchant| merchant.info[:name] == merch_name}
  end

  def find_items(merch_id)
    @calling_object.find_items_by_merch_id(merch_id)
  end

  def find_invoices(merch_id)
    @calling_object.find_invoices_by_merch_id(merch_id)
  end

  def find_favorite_customer(merch_id)
    @calling_object.find_favorite_customer(merch_id)
  end

  def find_customers_with_pending_invoices(merch_id)
    @calling_object.find_customers_with_pending_invoices(merch_id)
  end

  def find_revenue_per_merchant(merch_id)
    @calling_object.find_revenue_per_merchant(merch_id)
  end

  def find_revenue_by_date_per_merchant(date, merch_id)
    @calling_object.find_revenue_by_date_per_merchant(date, merch_id)
  end

  def find_item_total(merch_id)
    @calling_object.find_item_total(merch_id)
  end

  def most_revenue(num_of_merch)
    @collection.sort_by {|merchant| -merchant.revenue}[0..(num_of_merch - 1)]
  end

  def most_items(num_of_merch)
    @collection.sort_by {|merchant| -merchant.item_total}[0..(num_of_merch - 1)]
  end

  def revenue(date)
    revenues = @collection.map {|merchant| (merchant.revenue(date))}
    revenues.delete(nil)
    revenues.reduce(:+)
  end
end
