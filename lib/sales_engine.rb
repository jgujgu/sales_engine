require 'csv'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'item_repository'
require_relative 'invoice_item_repository'
require_relative 'customer_repository'
require_relative 'transaction_repository'
require_relative 'generic_repo'
require_relative 'sales_searcher'
require 'byebug'

class SalesEngine
  include SalesSearcher
	attr_reader :merchant_repository, :invoice_repository, :item_repository, :invoice_repository, :invoice_item_repository, :customer_repository, :transaction_repository

	def startup
		@merchant_repository  = MerchantRepository.new("merchants.csv", Merchant, self)
		@invoice_repository = InvoiceRepository.new("invoices.csv", Invoice, self)
		@item_repository = ItemRepository.new("items.csv", Item, self)
		@invoice_item_repository = InvoiceItemRepository.new("invoice_items.csv", InvoiceItem, self)
		@customer_repository = CustomerRepository.new("customers.csv", Customer, self)
		@transaction_repository = TransactionRepository.new("transactions.csv", Transaction, self)
	end

  def find_customers_by_merch_id(merch_id)
    invoices = self.find_invoices_by_merch_id(merch_id)
    invoices_grouped_by_customer = invoices.group_by.each_with_index do |invoice, index|
      invoices[index].info[:customer_id] 
    end

    invoices_grouped_by_customer.each do |cust_id, invoices|
      invoices.each_with_index do |invoice, index| 
        transactions = self.find_transactions_by_invoice_id(invoice.info[:id])
        results = transactions.map {|transaction| transaction.info[:result]}
        results.any? {|result| result == "success"} ? invoices[index] = 1 : invoices[index] = -1
      end
    end
    puts invoices_grouped_by_customer
  end

  def divide_customers_by_success_fail
    #success_fail = partition {|transaction| transaction.result == "success"}
  end
end
