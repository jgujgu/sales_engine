require 'minitest/autorun'
require 'bigdecimal/util'
require 'bigdecimal'
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
    assert_equal BigDecimal("0.410605E4").to_digits, @sales_engine.merchant_repository.collection[0].revenue.to_digits
  end

  def test_it_finds_revenue_of_merchant_by_date
    assert_equal BigDecimal("0.148125E4").to_digits, @sales_engine.merchant_repository.collection[0].revenue("2014-12-12").to_digits
  end

  def test_it_finds_x_top_merchants_by_revenue
    merchants = @sales_engine.merchant_repository.most_revenue(2)
    assert_equal "3", merchants[0].info[:id]
    assert_equal "1", merchants[1].info[:id]
    refute merchants[2]
  end

  def test_it_finds_revenue_by_date_across_merchants
    assert_equal BigDecimal("0.1838725E5").to_digits, @sales_engine.merchant_repository.revenue("2014-12-12").to_digits
  end

  def test_it_finds_top_selling_merchants_by_product
    merchants = @sales_engine.merchant_repository.most_items(2)
    assert_equal "2", merchants[0].info[:id]
    assert_equal "3", merchants[1].info[:id]
    refute merchants[2]
  end

  def test_it_finds_top_selling_items_by_qty
    items = @sales_engine.item_repository.most_items(2)
    assert_equal "6", items[0].info[:id]
    assert_equal "5", items[1].info[:id]
    refute items[2]
  end

  def test_it_finds_top_grossing_items
    items = @sales_engine.item_repository.most_revenue(2)
    assert_equal "5", items[0].info[:id]
    assert_equal "7", items[1].info[:id]
    refute items[2]
  end

  def test_it_finds_the_most_popular_day
    assert_equal "2012-03-03", @sales_engine.item_repository.collection[5].best_day
  end

  def test_it_finds_customer_transactions
    assert_equal 9, @sales_engine.customer_repository.collection[2].transactions.flatten.count
  end
end
