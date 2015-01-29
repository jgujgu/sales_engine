#require 'minitest/autorun'
#require 'bigdecimal/util'
#require 'bigdecimal'
#require 'minitest/pride'
#require './lib/sales_engine'
#require 'byebug'

#class SalesEngineBITest < MiniTest::Test
  #def setup
    #@sales_engine = SalesEngine.new('./fake_data')
    #@sales_engine.startup

    #customer = @sales_engine.customer_repository.collection[5]
    #merchant = @sales_engine.merchant_repository.collection[1]
    #item1 = @sales_engine.item_repository.collection[0]
    #item2 = @sales_engine.item_repository.collection[1]
    #item3 = @sales_engine.item_repository.collection[2]

    #@invoice_repo = @sales_engine.invoice_repository
    #@invoice_repo.create(customer: customer, merchant: merchant, status: "shipped", items: [item1, item2, item3, item1])
  #end

  #def test_it_creates_new_invoice_object_with_given_transaction_info
    #invoice = @invoice_repo.collection[-1]
    #assert_equal "100", invoice.info[:id]
    #assert_equal "2", invoice.info[:merchant_id]
    #assert_equal "6", invoice.info[:customer_id]
    #assert_equal invoice.info[:created_at], invoice.info[:updated_at]
  #end

  #def test_it_counts_item_qty
    #skip
  #end

  #def test_it_grabs_merchant_id
    #skip
  #end
#end
