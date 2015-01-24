require 'csv'

require 'bigdecimal'
require 'bigdecimal/util'
require 'date'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'item_repository'
require_relative 'invoice_item_repository'
require_relative 'customer_repository'
require_relative 'transaction_repository'
require_relative 'generic_repo'
require_relative 'sales_finder'
require 'byebug'

class SalesEngine
  include SalesFinder
  attr_reader :merchant_repository, :invoice_repository, :item_repository, :invoice_repository, :invoice_item_repository, :customer_repository, :transaction_repository

  def initialize(file_path)
    @file_path = file_path
  end

  def startup
    @merchant_repository  = MerchantRepository.new("#{@file_path}merchants.csv", Merchant, self)
    @invoice_repository = InvoiceRepository.new("#{@file_path}invoices.csv", Invoice, self)
    @item_repository = ItemRepository.new("#{@file_path}items.csv", Item, self)
    @invoice_item_repository = InvoiceItemRepository.new("#{@file_path}invoice_items.csv", InvoiceItem, self)
    @customer_repository = CustomerRepository.new("#{@file_path}customers.csv", Customer, self)
    @transaction_repository = TransactionRepository.new("#{@file_path}transactions.csv", Transaction, self)
  end

  def analyze_success_fail_of_customer_by_invoice(invoice_per_customer_per_merchant)
    invoice_per_customer_per_merchant.each do |cust_id, invoices|
      invoices.each_with_index do |invoice, index|
        transactions = self.find_transactions_by_invoice_id(invoice.info[:id])
        results = transactions.map {|transaction| transaction.info[:result]}
        results.any? {|result| result == "success"} ? invoices[index] = 1 : invoices[index] = -1
      end
    end
    invoice_per_customer_per_merchant
  end

  def show_success_fail_of_customer_by_invoice_per_merchant(merch_id)
    invoices_grouped_by_customer = self.group_invoices_by_customer_per_merchant(merch_id)
    self.analyze_success_fail_of_customer_by_invoice(invoices_grouped_by_customer)
  end

  def find_customers_with_pending_invoices(merch_id)
    invoices_in_success_fail_per_customer = self.show_success_fail_of_customer_by_invoice_per_merchant(merch_id)
    customers_with_pending_invoices_hash = invoices_in_success_fail_per_customer.select {|cust_id, successes| successes.include?(-1)}
    customers_with_pending_invoices_hash.map {|customer, fails| customer}
  end

  def find_favorite_customer(merch_id)
    invoices_in_success_fail_per_customer = self.show_success_fail_of_customer_by_invoice_per_merchant(merch_id)
    min, max = invoices_in_success_fail_per_customer.minmax_by {|cust_id, successes| successes.inject(:+)}
    max[0]
  end

  def group_invoices_by_customer_per_merchant(merch_id)
    invoices = self.find_invoices_by_merch_id(merch_id)
    invoices.group_by.each_with_index {|invoice, index| invoices[index].info[:customer_id]}
  end

  def find_successful_invoices_by_merch_id(merch_id)
    successful_invoices = []
    invoices_grouped_by_customer = self.group_invoices_by_customer_per_merchant(merch_id)
    invoices_grouped_by_customer_clone = Marshal.load(Marshal.dump(invoices_grouped_by_customer))
    successes_and_fails = self.analyze_success_fail_of_customer_by_invoice(invoices_grouped_by_customer)
    successes_and_fails.each do |cust_id, success_fail|
      success_fail.each_with_index do |success, index|
        successful_invoices << invoices_grouped_by_customer_clone [cust_id][index] if success_fail[index] == 1
      end
    end
    successful_invoices
  end

  def add_revenue_of_successful_invoices(successful_invoices)
    invoice_items = self.find_invoice_items_from_successful_invoices(successful_invoices)
    total_per_item = invoice_items.map {|invoice_item| invoice_item.info[:quantity].to_i * invoice_item.info[:unit_price].to_i}
    cents_as_string = total_per_item.reduce(:+).to_s
    dollars = cents_as_string.insert(-3, ".")
    BigDecimal.new(dollars)
  end

  def find_invoice_items_from_successful_invoices(successful_invoices)
    successful_invoices.map {|invoice| self.find_invoice_items_by_invoice_id(invoice.info[:id])}.flatten
  end

  def add_items_of_successful_invoices(successful_invoices)
    invoice_items = self.find_invoice_items_from_successful_invoices(successful_invoices)
    invoice_items.reduce(0) {|sum, invoice_item| sum + invoice_item.info[:quantity].to_i}
  end

  def exception_to_handle_missing_invoices(successful_invoices)
    begin
      self.add_revenue_of_successful_invoices(successful_invoices)
    rescue
    end
  end

  def find_revenue_by_date_per_merchant(date, merch_id)
    successful_invoices = self.find_successful_invoices_by_merch_id(merch_id)
    successful_invoices_on_date = successful_invoices.select do |invoice|
      created_date = Date.parse(invoice.info[:created_at])
      date == created_date.strftime("%F")
    end
    self.exception_to_handle_missing_invoices(successful_invoices_on_date)
  end

  def find_revenue_per_merchant(merch_id)
    successful_invoices = self.find_successful_invoices_by_merch_id(merch_id)
    self.exception_to_handle_missing_invoices(successful_invoices)
  end

  def find_item_total(merch_id)
    successful_invoices = self.find_successful_invoices_by_merch_id(merch_id)
    self.add_items_of_successful_invoices(successful_invoices)
  end

  def find_successful_invoice_items_by_merch_id_per_item_id(item_id, merch_id)
    successful_invoices = self.find_successful_invoices_by_merch_id(merch_id)
    invoice_items = self.find_invoice_items_from_successful_invoices(successful_invoices)
    invoice_items.select {|invoice_item| invoice_item.info[:item_id] == item_id}
  end

  def find_revenue_by_item(item_id, merch_id)
    invoice_items_with_item_id = self.find_successful_invoice_items_by_merch_id_per_item_id(item_id, merch_id)
    invoice_items_with_item_id.reduce(0) {|sum, invoice_item| sum + invoice_item.info[:quantity].to_i * invoice_item.info[:unit_price].to_i}
  end

  def find_qty_by_item(item_id, merch_id)
    invoice_items_with_item_id = self.find_successful_invoice_items_by_merch_id_per_item_id(item_id, merch_id)
    invoice_items_with_item_id.reduce(0) {|sum, invoice_item| sum + invoice_item.info[:quantity].to_i}
  end
end
