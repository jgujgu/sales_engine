require 'minitest/autorun'
require 'minitest/pride'
require './lib/customer'

class CustomerTest < MiniTest::Test
  def test_it_initializes_with_values
    customer = Customer.new(nil)
    customer.info = {id: 9, first_name: "fred", last_name: "flinstone",created_at: "2010", updated_at: "2015"}
    assert_equal 9, customer.info[:id]
    assert_equal "fred", customer.info[:first_name]
    assert_equal "flinstone", customer.info[:last_name]
    assert_equal "2010", customer.info[:created_at]
    assert_equal "2015", customer.info[:updated_at]
  end
end
