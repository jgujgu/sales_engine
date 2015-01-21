require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'

class ItemTest < MiniTest::Test
  def test_it_initializes_with_values
    item = Item.new(nil)
    item.info = {id: 9, name: "ham", updated_at: "2015"}
    assert_equal 9, item.info[:id] = 9
    assert_equal "ham", item.info[:name] = "ham"
    assert_equal "2015", item.info[:updated_at] = "2015"
  end
end
