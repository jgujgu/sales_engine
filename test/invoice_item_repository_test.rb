require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_item_repository'
require 'byebug'

class InvoiceItemRepositoryTest < MiniTest::Test
  def setup
    @invoice_item_repo = InvoiceItemRepository.new("./data/invoice_items.csv", InvoiceItem)
  end

  def test_it_exists
    assert @invoice_item_repo
  end

  def test_it_creates_21687_objects
    assert_equal 21687, @invoice_item_repo.collection.count
  end

  def test_the_first_few_objects_exist_with_certain_info
    assert_equal "539", @invoice_item_repo.collection.first.info[:item_id]
    assert_equal "2012-03-27 14:54:09 UTC", @invoice_item_repo.collection[4].info[:created_at]
    assert_equal "2012-03-27 14:54:09 UTC", @invoice_item_repo.collection[5].info[:updated_at]
  end

  def test_it_returns_the_same_calling_object
    assert_equal @invoice_item_repo.collection.first.calling_object, @invoice_item_repo.collection[9].calling_object
  end

  def test_it_finds_all
    assert @invoice_item_repo.all
  end

  def test_it_finds_one_random
    assert @invoice_item_repo.random
  end

  def test_it_finds_by_id
    assert_equal "29", @invoice_item_repo.find_one_by_id("29")[:id]
    assert_equal "35", @invoice_item_repo.find_one_by_id("35")[:id]
    assert_equal "76", @invoice_item_repo.find_one_by_id("76")[:id]
  end
end
