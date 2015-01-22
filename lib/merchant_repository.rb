require_relative "merchant"
require_relative "generic_repo"

class MerchantRepository < GenericRepo
	def find_one_by_name(merch_name)
    @collection.find {|merchant| merchant.info[:name] == merch_name}
	end

  def find_items(merchant_id)
    @calling_object.find_items_by_merch_id(merchant_id)
  end

  def find_invoices(merchant_id)
    @calling_object.find_invoices_by_merch_id(merchant_id)
  end
end
