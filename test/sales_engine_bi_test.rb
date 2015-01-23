require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineBITest < MiniTest::Test
	def setup
		@sales_engine = SalesEngine.new('./data/')
		@sales_engine.startup
	end

  def test_it_finds_transactions_from_merchant
    query = @sales_engine.merchant_repository.collection[42].favorite_customer
    puts query
    min, max = query.minmax_by {|cust_id, successes| successes.inject(:+)}
    puts min[0] 
    puts max[0]
    #assert_equal Array, query.class
  end
end
