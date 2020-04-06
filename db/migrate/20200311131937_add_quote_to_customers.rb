class AddQuoteToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_reference :customers, :quote, foreign_key: true
  end
end
