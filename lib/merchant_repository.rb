require_relative "merchant"
require_relative "generic_repo"

class MerchantRepository < GenericRepo
	def find_by_name(merch_name)
    @collection.find {|merchant| merchant.info[:name] == merch_name}
	end
end