require_relative 'entry'
class InvoiceItem < Entry
  def invoice
    @calling_object.find_invoice(@info[:invoice_id])
  end

  def item
    @calling_object.find_item(@info[:item_id])
  end

  def item_id
    @info[:item_id].to_i
  end
end
