require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice'

class InvoiceTest < MiniTest::Test
  def test_it_initializes_with_values
    invoice = Invoice.new(nil)
    invoice.info = {id: 9, customer_id: "19993" , merchant_id: "microsoft", status: "unpaid", created_at: "2010", updated_at: "2015"}
    assert_equal 9, invoice.info[:id]
    assert_equal "19993", invoice.info[:customer_id]
    assert_equal "unpaid", invoice.info[:status]
    assert_equal "2010", invoice.info[:created_at]
    assert_equal "2015", invoice.info[:updated_at]
  end
end
