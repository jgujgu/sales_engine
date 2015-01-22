require_relative "item"
require_relative "generic_repo"

class ItemRepository < GenericRepo
	def find_by_merchant_id(merch_id)
    @collection.select {|item| item.info[:merchant_id] == merch_id}.sample.info
	end

  def find_all_by_merchant_id(merch_id)
    @collection.select {|item| item.info[:merchant_id] == merch_id}.map {|item| item.info}
	end
end
