require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'
require 'byebug'

class MerchantRepositoryTest < MiniTest::Test
  def setup
    @merch_repo = MerchantRepository.new("merchants.csv", Merchant)
  end

  def test_it_exists
    assert @merch_repo
  end

  def test_it_creates_100_objects
    assert_equal 100, @merch_repo.collection.count
  end

  def test_the_first_few_objects_exist_with_certain_info
    assert_equal "Schroeder-Jerde", @merch_repo.collection.first.info[:name]
    assert_equal "2012-03-27 14:53:59 UTC", @merch_repo.collection[4].info[:created_at]
    assert_equal "2012-03-27 16:12:25 UTC", @merch_repo.collection[5].info[:updated_at]
  end

  def test_it_returns_the_same_calling_object
    assert_equal @merch_repo.collection.first.calling_object, @merch_repo.collection[9].calling_object
  end

  def test_it_finds_all
    assert @merch_repo.all
  end
  
  def test_it_finds_one_random
    assert @merch_repo.random
  end

  def test_it_finds_by_id 
    assert_equal "29", @merch_repo.find_by_id("29")[:id]
    assert_equal "35", @merch_repo.find_by_id("35")[:id]
    assert_equal "76", @merch_repo.find_by_id("76")[:id]
  end
end
