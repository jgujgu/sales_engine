require 'minitest/autorun'
require 'minitest/pride'
require './lib/transaction'

class TransactionTest < MiniTest::Test
  def test_it_initializes_with_values
    transaction = Transaction.new(nil)
    transaction.info = {id: 9, invoice_id: "19993" , credit_card_number: "4654405418249632", credit_card_expiration_date: "5", result: "success", created_at: "2010", updated_at: "2015"}
    assert_equal 9, transaction.info[:id]
    assert_equal "19993", transaction.info[:invoice_id]
    assert_equal "4654405418249632", transaction.info[:credit_card_number]
    assert_equal "success", transaction.info[:result]
    assert_equal "2010", transaction.info[:created_at]
    assert_equal "2015", transaction.info[:updated_at]
  end
end
