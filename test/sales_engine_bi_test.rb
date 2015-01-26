require 'minitest/autorun'
require 'bigdecimal/util'
require 'bigdecimal'
require 'minitest/pride'
require './lib/sales_engine'
require 'byebug'

class SalesEngineBITest < MiniTest::Test
  def setup
    @sales_engine = SalesEngine.new('./fake_data/')
    @sales_engine.startup
  end

  def test_it_finds_transactions_from_merchant
    fav_cust = @sales_engine.merchant_repository.collection[0].favorite_customer
    delinquent_custs = @sales_engine.merchant_repository.collection[0].customers_with_pending_invoices

    assert_equal "3", fav_cust
    assert_equal ["4", "1"], delinquent_custs
  end

  def test_it_finds_revenue_of_merchant
    revenue_digits = @sales_engine.merchant_repository.collection[0].revenue.to_digits
    assert_equal BigDecimal("0.410605E4").to_digits, revenue_digits
  end

  def test_it_finds_revenue_of_merchant_by_date
    revenue_digits_by_date = @sales_engine.merchant_repository.collection[0].revenue("2014-12-12").to_digits
    assert_equal BigDecimal("0.148125E4").to_digits, revenue_digits_by_date
  end

  def test_it_finds_x_top_merchants_by_revenue
    merchant_1, merchant_2, merchant_3 = @sales_engine.merchant_repository.most_revenue(2)
    merch_1_id = merchant_1.info[:id]
    merch_2_id = merchant_2.info[:id]

    assert_equal "3", merch_1_id
    assert_equal "1", merch_2_id
    refute merchant_3
  end

  def test_it_finds_revenue_by_date_across_merchants
    revenue_by_date = @sales_engine.merchant_repository.revenue("2014-12-12").to_digits
    assert_equal BigDecimal("0.1838725E5").to_digits, revenue_by_date
  end

  def test_it_finds_top_selling_merchants_by_product
    merchant_1, merchant_2, merchant_3 = @sales_engine.merchant_repository.most_items(2)
    merch_1_id = merchant_1.info[:id]
    merch_2_id = merchant_2.info[:id]

    assert_equal "2", merch_1_id
    assert_equal "3", merch_2_id
    refute merchant_3
  end

  def test_it_finds_top_selling_items_by_qty
    item_1, item_2, item_3 = @sales_engine.item_repository.most_items(2)
    item_id_1 = item_1.info[:id]
    item_id_2 = item_2.info[:id]

    assert_equal "6", item_id_1
    assert_equal "5", item_id_2
    refute item_3
  end

  def test_it_finds_top_grossing_items
    item_1, item_2, item_3 = @sales_engine.item_repository.most_revenue(2)
    item_id_1 = item_1.info[:id]
    item_id_2 = item_2.info[:id]

    assert_equal "5", item_id_1
    assert_equal "7", item_id_2
    refute item_3
  end

  def test_it_finds_the_most_popular_day
    item_best_day = @sales_engine.item_repository.collection[5].best_day
    assert_equal "2012-03-03", item_best_day
  end

  def test_it_finds_customer_transactions
    num_of_transactions_for_cust = @sales_engine.customer_repository.collection[2].transactions.count
    assert_equal 9, num_of_transactions_for_cust
  end

  def test_it_finds_the_favorite_merchant
    merch_id = @sales_engine.customer_repository.collection[2].favorite_merchant
    assert_equal "3", merch_id
  end
end
