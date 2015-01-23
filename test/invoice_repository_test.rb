require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_repository'
require 'byebug'

class InvoiceRepositoryTest < MiniTest::Test
  def setup
    @invoice_repo = InvoiceRepository.new("./data/invoices.csv", Invoice)
  end

  def test_it_exists
    assert @invoice_repo
  end

  def test_it_creates_4843_objects
    assert_equal 4843, @invoice_repo.collection.count
  end

  def test_the_first_few_objects_exist_with_certain_info
    assert_equal "26", @invoice_repo.collection.first.info[:merchant_id]
    assert_equal "2012-03-07 19:54:10 UTC", @invoice_repo.collection[4].info[:created_at]
    assert_equal "2012-03-09 01:54:10 UTC", @invoice_repo.collection[5].info[:updated_at]
  end

  def test_it_returns_the_same_calling_object
    assert_equal @invoice_repo.collection.first.calling_object, @invoice_repo.collection[9].calling_object
  end

  def test_it_finds_all
    assert @invoice_repo.all
  end
  
  def test_it_finds_one_random
    assert @invoice_repo.random
  end

  def test_it_finds_by_id 
    assert_equal "29", @invoice_repo.find_one_by_id("29")[:id]
    assert_equal "35", @invoice_repo.find_one_by_id("35")[:id]
    assert_equal "76", @invoice_repo.find_one_by_id("76")[:id]
  end
end
