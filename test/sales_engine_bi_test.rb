require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineBITest < MiniTest::Test
	def setup
		@sales_engine = SalesEngine.new('./fake_data/')
		@sales_engine.startup
	end

  def test_it_finds_transactions_from_merchant
    query = @sales_engine.merchant_repository.collection[0].favorite_customer
    puts query
    puts "\n"
    min, max = query.minmax_by {|cust_id, successes| successes.inject(:+)}
    puts min; puts max
    puts min[0] 
    puts max[0]
    puts "\n"
    puts query.select {|cust_id, successes| successes.include?(-1)}.class
    #assert_equal Array, query.class
  end
end
