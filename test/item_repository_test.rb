require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository'
require 'byebug'

class ItemRepositoryTest < MiniTest::Test
  def setup
    @item_repo = ItemRepository.new("items.csv", Item)
  end

  def test_it_exists
    assert @item_repo
  end

  def test_it_creates_2383_objects
    assert_equal 2483, @item_repo.collection.count
  end

  def test_the_first_few_objects_exist_with_certain_info
    description = "Numquam officiis reprehenderit eum ratione neque tenetur. Officia aut repudiandae eum at ipsum doloribus. Iure minus itaque similique. Ratione dicta alias asperiores minima ducimus nesciunt at."
    assert_equal "75107", @item_repo.collection.first.info[:unit_price]
    assert_equal "Item Expedita Aliquam", @item_repo.collection[4].info[:name]
    assert_equal description, @item_repo.collection[5].info[:description]
  end

  def test_it_returns_the_same_calling_object
    assert_equal @item_repo.collection.first.calling_object, @item_repo.collection[9].calling_object
  end

  def test_it_finds_all
    @item_repo.all
  end
  
  def test_it_finds_one_random
    assert @item_repo.random
  end

  def test_it_finds_by_id 
    assert_equal "193", @item_repo.find_by_id("193")[:id]
    assert_equal "999", @item_repo.find_by_id("999")[:id]
    assert_equal "242", @item_repo.find_by_id("242")[:id]
  end

  def test_it_finds_by_merchant_id
    assert @item_repo.find_by_merchant_id("3")
  end

  def test_it_finds_all_by_merchant_id
    assert @item_repo.find_all_by_merchant_id("3")
  end
end
