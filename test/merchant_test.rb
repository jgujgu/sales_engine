require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'

class MerchantTest < MiniTest::Test
  def test_it_initializes_with_values
    merchant = Merchant.new(nil)
    merchant.info = {id: 9, name: "microsoft", created_at: "2010", updated_at: "2015"}
    assert_equal 9, merchant.info[:id]
    assert_equal "microsoft", merchant.info[:name]
    assert_equal "2010", merchant.info[:created_at]
    assert_equal "2015", merchant.info[:updated_at]
  end
end
