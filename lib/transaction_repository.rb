require_relative "transaction"
require_relative "generic_repo"

class TransactionRepository < GenericRepo
  def find_one_by_invoice_id(in_id)
    @collection.select {|item| item.info[:invoice_id] == in_id}.sample
  end

  def find_all_by_invoice_id(in_id)
    @collection.select {|item| item.info[:invoice_id] == in_id}
  end

  def find_invoice(in_id)
    @calling_object.find_invoice_by_invoice_id(in_id)
  end

  def find_by_credit_card_number(cc_num)
    @collection.find {|trans| trans.info[:credit_card_number] == cc_num.to_s}
  end

  def find_all_by_result(result_query)
    @collection.select {|trans| trans.info[:result] == result_query}
  end
end
