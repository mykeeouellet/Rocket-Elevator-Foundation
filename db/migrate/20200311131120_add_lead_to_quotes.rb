class AddLeadToQuotes < ActiveRecord::Migration[5.2]
  def change
    add_reference :quotes, :lead, foreign_key: true
  end
end
