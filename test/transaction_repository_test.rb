require 'minitest/autorun'
require 'minitest/pride'
require './lib/transaction_repository'
require 'byebug'

class TransactionRepositoryTest < MiniTest::Test
  def setup
    @transaction_repo = TransactionRepository.new("./data/transactions.csv", Transaction)
  end

  def test_it_exists
    assert @transaction_repo
  end

  def test_it_creates_5595_objects
    assert_equal 5595, @transaction_repo.collection.count
  end

  def test_the_first_few_objects_exist_with_certain_info
    assert_equal "4654405418249632", @transaction_repo.collection.first.info[:credit_card_number]
    assert_equal "2012-03-27 14:54:10 UTC", @transaction_repo.collection[4].info[:created_at]
    assert_equal "2012-03-27 14:54:10 UTC", @transaction_repo.collection[5].info[:updated_at]
  end

  def test_it_returns_the_same_calling_object
    assert_equal @transaction_repo.collection.first.calling_object, @transaction_repo.collection[9].calling_object
  end

  def test_it_finds_all
    assert @transaction_repo.all
  end

  def test_it_finds_one_random
    assert @transaction_repo.random
  end

  def test_it_finds_by_id
    assert_equal "29", @transaction_repo.find_one_by_id("29")[:id]
    assert_equal "35", @transaction_repo.find_one_by_id("35")[:id]
    assert_equal "76", @transaction_repo.find_one_by_id("76")[:id]
  end
end
