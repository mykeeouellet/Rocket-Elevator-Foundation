class AddCreatedAtToQuotes < ActiveRecord::Migration[5.2]
  def change
    add_column :quotes, :created_at, :datetime
  end
end
