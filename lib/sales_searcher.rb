module SalesSearcher
  def find_items_by_merch_id(merchant_id)
    @item_repository.find_all_by_merchant_id(merchant_id)
  end

  def find_invoices_by_merch_id(merchant_id)
    @invoice_repository.find_all_by_merchant_id(merchant_id)
  end 
  
  def find_invoices_by_cust_id(cust_id)
    @invoice_repository.find_all_by_customer_id(cust_id)
  end

  def find_invoice_by_invoice_id(in_id)
    @invoice_repository.find_one_by_id(in_id)
  end

  def find_item_by_item_id(item_id)
    @item_repository.find_one_by_id(item_id)
  end

  def find_customer_by_cust_id(cust_id)
    @customer_repository.find_one_by_id(cust_id)
  end

  def find_merchant_by_merch_id(merch_id)
    @merchant_repository.find_one_by_id(merch_id)
  end

  def find_transactions_by_invoice_id(in_id)
    @transaction_repository.find_all_by_invoice_id(in_id)
  end

  def find_invoice_items_by_invoice_id(in_id)
    @invoice_item_repository.find_all_by_invoice_id(in_id)
  end

  def find_invoice_items_by_item_id(item_id)
    @invoice_item_repository.find_all_by_item_id(item_id)
  end

  def find_items_by_invoice_id(in_id)
    invoice_items = self.find_invoice_items_by_invoice_id(in_id)
    invoice_items.map {|invoice_item| invoice_item.item}
  end
end