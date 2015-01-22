require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < MiniTest::Test
	def setup
		@sales_engine = SalesEngine.new
		@sales_engine.startup
	end

	def test_it_exists
		assert @sales_engine
	end

	def test_it_initializes_repos
		assert @sales_engine.merchant_repository
		assert @sales_engine.invoice_repository
		assert @sales_engine.item_repository
		assert @sales_engine.invoice_item_repository
		assert @sales_engine.customer_repository
		assert @sales_engine.transaction_repository
	end

	def test_it_queries_the_repos
		assert @sales_engine.merchant_repository.random
		assert @sales_engine.invoice_repository.random
		assert @sales_engine.item_repository.random
		assert @sales_engine.invoice_item_repository.random
		assert @sales_engine.customer_repository.random
		assert @sales_engine.transaction_repository.random
	end

	def test_merchant_finds_its_items
		query = @sales_engine.merchant_repository.collection[2].items
    assert_equal 26, query.count
	end
  
  def test_merchant_finds_its_invoices
		query = @sales_engine.merchant_repository.collection[20].invoices
    assert_equal 39, query.count
	end

  def test_customer_finds_its_invoices
		query = @sales_engine.customer_repository.collection[123].invoices
    assert_equal 2, query.count
    end
  
  def test_transaction_finds_its_invoice
		query = @sales_engine.transaction_repository.collection[456].invoice
    assert_equal Hash, query.class
  end

  def test_invoice_item_finds_its_invoice_and_item
		query_1 = @sales_engine.invoice_item_repository.collection[17302].invoice
		query_2 = @sales_engine.invoice_item_repository.collection[17302].item

    assert_equal Hash, query_1.class
    assert_equal Hash, query_2.class
  end

  def test_item_finds_its_merchant
		query = @sales_engine.item_repository.collection[93].merchant
    assert_equal Hash, query.class
  end

  def test_invoice_finds_its_transaction_and_invoice_items
		query_1 = @sales_engine.invoice_repository.collection[3].transactions
		query_2 = @sales_engine.invoice_repository.collection[3].invoice_items

    assert_equal Array, query_1.class
    assert_equal Array, query_2.class
  end

  def test_invoice_finds_its_customer_and_merchant
		query_1 = @sales_engine.invoice_repository.collection[3].customer
		query_2 = @sales_engine.invoice_repository.collection[3].merchant

    assert_equal Hash, query_1.class
    assert_equal Hash, query_2.class
  end

  def test_invoice_finds_its_transaction_and_invoice_items
		query = @sales_engine.invoice_repository.collection[3].items
    assert_equal Array, query.class
  end
end
