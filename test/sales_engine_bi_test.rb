require 'minitest/autorun'

require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineBITest < MiniTest::Test
	def setup
		@sales_engine = SalesEngine.new('./fake_data/')
		@sales_engine.startup
	end

  def test_it_finds_transactions_from_merchant
    query_1 = @sales_engine.merchant_repository.collection[0].favorite_customer
    query_2 = @sales_engine.merchant_repository.collection[0].customers_with_pending_invoices

    assert_equal "3", query_1
    assert_equal ["4", "1"], query_2
  end


  def test_it_finds_revenue_of_merchant
    assert_equal 0.410536E4, @sales_engine.merchant_repository.collection[0].revenue
  end
end
