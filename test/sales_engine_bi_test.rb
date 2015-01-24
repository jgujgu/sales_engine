require 'minitest/autorun'
require 'bigdecimal/util'
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

  def test_it_finds_revenue_of_merchant_by_date
    assert_equal 0.148056E4, @sales_engine.merchant_repository.collection[0].revenue("2014-12-12")
  end

  def test_it_finds_x_top_merchants_by_revenue
    merchants = @sales_engine.merchant_repository.most_revenue(2)
    assert_equal "3", merchants[0].info[:id]
    assert_equal "1", merchants[1].info[:id]
  end

  def test_it_finds_revenue_by_date_across_merchants
    assert_equal 0.1838056E5, @sales_engine.merchant_repository.revenue("2014-12-12")
  end

  def test_it_finds_top_selling_merchants_by_product
    merchants = @sales_engine.merchant_repository.most_items(2)
    assert_equal "2", merchants[0].info[:id]
    assert_equal "3", merchants[1].info[:id]
  end
end
