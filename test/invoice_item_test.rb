require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_item'

class InvoiceItemTest < MiniTest::Test
  def test_it_initializes_with_values
    invoice_item = InvoiceItem.new(nil)
    invoice_item.info = {id: 9, item_id: "19993" , quantity: "10", unit_price: "5", created_at: "2010", updated_at: "2015"}
    assert_equal 9, invoice_item.info[:id]
    assert_equal "19993", invoice_item.info[:item_id]
    assert_equal "10", invoice_item.info[:quantity]
    assert_equal "5", invoice_item.info[:unit_price]
    assert_equal "2010", invoice_item.info[:created_at]
    assert_equal "2015", invoice_item.info[:updated_at]
  end
end
