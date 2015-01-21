require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'

class MerchantRepositoryTest < MiniTest::Test
	def setup
		@merchant_repository = MerchantRepository.new("merchants.csv", Merchant)
	end

	def test_it_exists
		assert @merchant_repository
	end
end
