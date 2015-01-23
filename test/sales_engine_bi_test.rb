require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineBITest < MiniTest::Test
	def setup
		@sales_engine = SalesEngine.new
		@sales_engine.startup
	end

  def test_it_finds_transactions_from_merchant
    query = @sales_engine.merchant_repository.collection[42].favorite_customer
    #assert_equal Array, query.class
  end
end
