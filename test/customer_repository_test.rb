require 'minitest/autorun'
require 'minitest/pride'
require './lib/customer_repository'
require 'byebug'

class CustomerRepositoryTest < MiniTest::Test
  def setup
    @customer_repo = CustomerRepository.new("./data/customers.csv", Customer)
  end

  def test_it_exists
    assert @customer_repo
  end

  def test_it_creates_1000_objects
    assert_equal 1000, @customer_repo.collection.count
  end

  def test_the_first_few_objects_exist_with_certain_info
    assert_equal "Joey", @customer_repo.collection.first.info[:first_name]
    assert_equal "2012-03-27 14:54:10 UTC", @customer_repo.collection[4].info[:created_at]
    assert_equal "2012-03-27 14:54:10 UTC", @customer_repo.collection[5].info[:updated_at]
  end

  def test_it_returns_the_same_calling_object
    assert_equal @customer_repo.collection.first.calling_object, @customer_repo.collection[9].calling_object
  end

  def test_it_finds_all
    assert @customer_repo.all
  end

  def test_it_finds_one_random
    assert @customer_repo.random
  end

  def test_it_finds_by_id
    assert_equal "29", @customer_repo.find_one_by_id("29").info[:id]
    assert_equal "35", @customer_repo.find_one_by_id("35").info[:id]
    assert_equal "76", @customer_repo.find_one_by_id("76").info[:id]
  end
end
